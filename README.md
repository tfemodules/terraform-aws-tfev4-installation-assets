# TFEv4 External Services

A Terraform configuration to manage an S3 bucket used to hold the TFE installation assets.

## Description

The Terraform configuration provisions:

- S3 bucket. The bucket is not public and has no associated policies which restrict access.

- S3 bucket objects
  - SSL certificate to setup TFE with.
  - The private key to the SSL certificate
  - TFE license file.

**Caveat:** The S3 objects are created from local files. If these files change or are missing on subsequent runs, the TFE configuration will update the files or throw an error if they are missing. 

## Usage

For instructions on how to run Terraform configuration refer to the root module [readme](../README.md#Usage).

## Input Variables

The available input variables for the module are described in the table below.

| Variable | Type | Default | Description |
| -------- | ---- | ------- | ----------- |
| s3_bucket_name | `string` | | Name of the s3 bucket to create. |
| s3_force_delete | `bool` | `true` | Whether all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. |
| tfe_certificate_path | `string` | `null` | Path to the local file containing the SSL certificate to upload to the S3 bucket. Required unless tfe_certificate is provided. |
| tfe_certificate | `string` | `null` | SSL certificate to upload to the S3 bucket. Considered only if tfe_certificate_path is not provided. |
| tfe_certificate_key_path | `string` | `null` | Path to the local file containing the SSL certificate private key to upload to the S3 bucket. Required unless tfe_certificate_key is provided. |
| tfe_certificate_key | `string` | `null` | SSL certificate private key to upload to the S3 bucket. Considered only if tfe_certificate_key_path is not provided. |
| tfe_license_path | `string` | `null` | Path to the local file containing the TFE license to upload to the S3 bucket. Required unless tfe_license_b64 is provided. |
| tfe_license_b64 | `string` | `null` | Base64 encoded TFE license to upload to the S3 bucket. Considered only if tfe_license_path is not provided. |
| common_tags | `map(string)` | `{}` | Tags to apply to all resources. |

### Example on obtaining values for specific variables

Below are some commands on how to obtain the values for some of the input variables

* Obtain the base64 encoded value of the TFE license file

  ```bash
  base64 -i license_file.rli -o license.rli.b64
  ```
  The content of the `license.rli.b64` will be a single line string that can be provided to the `tfe_license_b64` input variable.

* Remove new lines from a PEM encoded certificate

  ```bash
  cat cert.pem | tr -d '\n\r'
  ```
  The output of the command will be a single line string that can be provided to the `tfe_certificate` and `tfe_certificate_key` variables.

## Outputs

The outputs defined for the module are described in the table below.

| Output | Type | Description |
| -------- | ---- | ----------- |
| tfe_cert | `string` | S3 path for the SSL certificate. |
| tfe_cert_key | `string` | S3 path for the SSL certificate private key. |
| tfe_license | `string` | S3 path for the TFE license file. |
| s3_bucket_name | `string` | The name of the S3 bucket. Should be the same as what is specidiead in the input variable s3_bucket_name or empty string if creation was disabled. |

## Example

```HCL
module "tfe_installation_assets" {
  source = "git::https://github.com/tfemodules/terraform-aws-tfev4-installation-assets.git"

  s3_bucket_name           = "tfe-installation-assets"
  tfe_certificate_path     = "/path/to/tfe-cert.pem"
  tfe_certificate_key_path = "/path/to/tfe-cert.privkey.pem"
  tfe_license_path         = "/path/to/tfe-license.rli"
  common_tags              = {
    project = "tfe"
  }
}
```
variable "s3_bucket_name" {
  type        = string
  description = "Name of the s3 bucket to create."
}

variable "s3_force_delete" {
  type        = bool
  description = "Whether all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error."
  default     = true
}

variable "tfe_certificate_path" {
  type        = string
  description = "Path to the local file containing the SSL certificate to upload to the S3 bucket. Required unless tfe_certificate is provided."
  default     = null
}

variable "tfe_certificate" {
  type        = string
  description = "SSL certificate to upload to the S3 bucket. Considered only if tfe_certificate_path is not provided."
  default     = null
}

variable "tfe_certificate_key_path" {
  type        = string
  description = "Path to the local file containing the SSL certificate private key to upload to the S3 bucket. Required unless tfe_certificate_key is provided."
  default     = null
}

variable "tfe_certificate_key" {
  type        = string
  description = "SSL certificate private key to upload to the S3 bucket. Considered only if tfe_certificate_key_path is not provided."
  default     = null
}

variable "tfe_license_path" {
  type        = string
  description = "Path to the local file containing the TFE license to upload to the S3 bucket. Required unless tfe_license_b64 is provided."
  default     = null
}

variable "tfe_license_b64" {
  type        = string
  description = "Base64 encoded TFE license to upload to the S3 bucket. Considered only if tfe_license_path is not provided."
  default     = null
}

variable "common_tags" {
  type        = map(string)
  description = "Tags to apply to all resources."
  default     = {}
}
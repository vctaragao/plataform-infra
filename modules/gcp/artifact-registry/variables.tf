variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "location" {
  description = "Artifact Registry location."
  type        = string
}

variable "repository_id" {
  description = "Artifact Registry repository ID."
  type        = string
}

variable "format" {
  description = "Repository format."
  type        = string
  default     = "DOCKER"
}

variable "mode" {
  description = "Artifact Registry repository mode."
  type        = string
  default     = "STANDARD_REPOSITORY"
}

variable "cleanup_policy_dry_run" {
  description = "Whether cleanup policies should run in dry-run mode."
  type        = bool
  default     = true
}

variable "immutable_tags" {
  description = "Whether Docker tags are immutable. Only applies to DOCKER repositories."
  type        = bool
  default     = false
}

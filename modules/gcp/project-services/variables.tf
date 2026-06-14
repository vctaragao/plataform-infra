variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "services" {
  description = "Set of Google APIs to keep enabled for the project."
  type        = set(string)
}

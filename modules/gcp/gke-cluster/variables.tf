variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "name" {
  description = "GKE cluster name."
  type        = string
}

variable "location" {
  description = "GKE cluster location."
  type        = string
}

variable "network" {
  description = "VPC network self link."
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork self link."
  type        = string
}

variable "cluster_secondary_range_name" {
  description = "Secondary range used for pods."
  type        = string
}

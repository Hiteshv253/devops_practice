variable "project_id" {
  description = "Your GCP project ID"
  type        = string
  default     = terrafrom-project-463812
}

variable "region" {
  description = "Region for resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zone for the VM"
  type        = string
  default     = "us-central1-a"
}

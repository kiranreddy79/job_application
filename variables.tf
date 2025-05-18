# =====================
# Global Variables
# =====================

variable "project_name" {
  description = "Project prefix for naming resources"
  type        = string
  default     = "job-portal"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

# =====================
# AWS Region
# =====================

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}


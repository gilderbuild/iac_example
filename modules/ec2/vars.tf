variable "app_name" {
  description = "app name"
  type        = string
}

variable "default_tags" {
  description = "Tags to apply to resources created by this module"
  type        = map(string)
}


variable "public_subnets" {
  description = "subnets on which the resources will be created"
  type        = list(string)
}

variable "cert_name" {
  description = "certificate name"
  type        = string
}

variable "vpc_id" {
  description = "vpc_id"
  type        = string
}

variable "env" {
  description = "environment"
  type        = string
}

variable "env_suffix_non_prod" {
  description = "environment suffix for non-prod envs"
  type        = string
}


variable "env_full_name" {
  description = "environment full name"
  type        = string
}


variable "default_tags" {
  description = "Tags to apply to resources created by this module"
  type        = map(string)
}

variable "app_source_secret" {
  description = "app source secret"
  type        = string
}


variable "app_target_secret" {
  description = "app target secret"
  type        = string
}


variable "fe_source_secret" {
  description = "frontend source secret"
  type        = string
}


variable "fe_target_secret" {
  description = "frontend target secret"
  type        = string
}


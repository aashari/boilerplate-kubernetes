variable "service_name" {
  type        = string
  description = "The name of the service"
}

variable "environment" {
  type        = string
  description = "The environment of the service"
}

variable "tags" {
  type        = map(string)
  description = "The tags of the service"
  default     = {}
}

variable "name" {
  description = "The cluster name, e.g cdn"
}

variable "ssh_key" {
  description = "SSH key filename to copy to the nodes"
  type = string
}

variable "instance_size" {
  description = "The instance size to use"
  default = "s-1vcpu-2gb"
}

variable "servers" {
  description = "Desired instance count"
  default     = 4
}

variable "DO_API_TOKEN" {
  description = "Digital Ocean R/W API token"
  type = string
}

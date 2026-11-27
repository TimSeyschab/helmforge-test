variable "namespace" {
  description = "Dedicated Kubernetes namespace managed by Terraform for Redis."
  type        = string
  nullable    = false

  validation {
    condition     = length(var.namespace) <= 63 && can(regex("^[a-z0-9]([a-z0-9-]*[a-z0-9])?$", var.namespace))
    error_message = "Use a valid Kubernetes namespace name."
  }
}

variable "redis_secret_name" {
  description = "Name of the Kubernetes Secret managed by Terraform."
  type        = string
  default     = "db-auth"
  nullable    = false

  validation {
    condition     = trimspace(var.redis_secret_name) != ""
    error_message = "Specify the name of the Kubernetes Secret."
  }
}

variable "redis_secret_key" {
  description = "Key containing the shared Redis and Sentinel password."
  type        = string
  default     = "redis-password"
  nullable    = false

  validation {
    condition     = trimspace(var.redis_secret_key) != ""
    error_message = "Specify the key holding the Redis password."
  }
}

variable "kubeconfig_path" {
  description = "Path to the kubeconfig for the target cluster."
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context" {
  description = "Kubeconfig context for the target cluster."
  type        = string
  default     = "kind-kind"
}

variable "redis_password" {
  description = "Existing Redis password to preserve when adopting a Secret. Terraform generates a password when omitted."
  type        = string
  sensitive   = true
  default     = null

  validation {
    condition     = var.redis_password == null ? true : length(var.redis_password) > 0
    error_message = "The password must not be empty."
  }
}

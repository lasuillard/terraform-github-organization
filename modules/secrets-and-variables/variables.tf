variable "create" {
  description = "Whether to create this module or not."
  type        = bool
  default     = true
}

variable "secrets" {
  description = <<-EOT
GitHub Actions secrets for this organization.

- Available values for `subject` are `"actions"`, `"codespaces"`, `"dependabot"`.
EOT
  type = list(object({
    subjects                = set(string)
    secret_name             = string
    encrypted_value         = optional(string)
    plaintext_value         = optional(string)
    visibility              = string
    selected_repository_ids = optional(set(number))
  }))
  default = []
}

variable "variables" {
  description = "GitHub Actions variables for this organization."
  type = list(object({
    variable_name           = string
    value                   = optional(string)
    visibility              = string
    selected_repository_ids = optional(set(number))
  }))
  default = []
}

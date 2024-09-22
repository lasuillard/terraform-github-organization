variable "create" {
  description = "Whether to create this module or not."
  type        = bool
  default     = true
}

variable "organization_permissions" {
  description = "GitHub Actions permissions for current organization."
  type = object({
    allowed_actions      = optional(string)
    enabled_repositories = optional(string)
    allowed_actions_config = optional(object({
      github_owned_allowed = bool
      patterns_allowed     = optional(set(string))
      verified_allowed     = optional(bool)
    }))
    enabled_repositories_config = optional(object({
      repository_ids = set(number)
    }))
  })
  nullable = true
  default  = null
}

variable "oidc_subject_claim_customization_template" {
  description = "A list of OpenID Connect claims."
  type = object({
    include_claim_keys = set(string)
  })
  nullable = true
  default  = null
}

variable "runner_groups" {
  description = "GitHub Actions runner groups for this organization."
  type = list(object({
    name                       = string
    restricted_to_workflows    = optional(bool)
    selected_repository_ids    = optional(set(number))
    selected_workflows         = optional(set(string))
    visibility                 = optional(string)
    allows_public_repositories = optional(bool)
  }))
  default = []
}

variable "secrets" {
  description = "GitHub Actions secrets for this organization."
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

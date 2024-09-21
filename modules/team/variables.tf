variable "create" {
  description = "Whether to create this module or not."
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the team."
  type        = string
}

variable "description" {
  description = "A description of the team."
  type        = string
}

variable "privacy" {
  description = "The level of privacy for the team. Must be one of `secret` or `closed`."
  type        = string
  nullable    = true
  default     = null
}

variable "parent_team_id" {
  description = "The ID or slug of the parent team, if this is a nested team."
  type        = string
  nullable    = true
  default     = null
}

variable "ldap_dn" {
  description = "The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise Server."
  type        = string
  nullable    = true
  default     = null
}

variable "create_default_maintainer" {
  description = "Adds a default maintainer to the team. Defaults to false and adds the creating user to the team when true."
  type        = bool
  nullable    = true
  default     = null
}

variable "settings" {
  description = "Settings for the team."
  type = object({
    review_request_delegation = optional(object({
      algorithm    = optional(string)
      member_count = optional(number)
      notify       = optional(bool)
    }))
  })
  nullable = true
  default  = null
}

variable "members" {
  description = "A list of members to add to the team."
  type = list(object({
    username = string
    role     = optional(string)
  }))
  default = []
}

variable "members_authoritative" {
  description = "Whether the members list is authoritative. If true, only the members in the list will be in the team."
  type        = bool
  default     = false
}

variable "repositories" {
  description = "A list of repositories to add to the team."
  type = list(object({
    repository = string
    permission = optional(string)
  }))
  default = []
}

variable "sync_group_mapping" {
  description = "Identity Provider (IdP) group connections within your GitHub teams. You must have team synchronization enabled for organizations owned by enterprise accounts."
  type = object({
    groups = optional(list(object({
      group_id          = string
      group_name        = string
      group_description = string
    })))
  })
  nullable = true
  default  = null
}

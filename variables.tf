variable "create" {
  description = "Whether to create this module or not."
  type        = bool
  default     = true
}

variable "settings" {
  description = "Organization settings."
  type = object({
    billing_email                                                = string
    company                                                      = string
    blog                                                         = string
    email                                                        = string
    twitter_username                                             = string
    location                                                     = string
    name                                                         = string
    description                                                  = string
    has_organization_projects                                    = optional(bool)
    has_repository_projects                                      = optional(bool)
    default_repository_permission                                = optional(bool)
    members_can_create_repositories                              = optional(bool)
    members_can_create_public_repositories                       = optional(bool)
    members_can_create_private_repositories                      = optional(bool)
    members_can_create_internal_repositories                     = optional(bool)
    members_can_create_pages                                     = optional(bool)
    members_can_create_public_pages                              = optional(bool)
    members_can_create_private_pages                             = optional(bool)
    members_can_fork_private_repositories                        = optional(bool)
    web_commit_signoff_required                                  = optional(bool)
    advanced_security_enabled_for_new_repositories               = optional(bool)
    dependabot_alerts_enabled_for_new_repositories               = optional(bool)
    dependabot_security_updates_enabled_for_new_repositories     = optional(bool)
    dependency_graph_enabled_for_new_repositories                = optional(bool)
    secret_scanning_enabled_for_new_repositories                 = optional(bool)
    secret_scanning_push_protection_enabled_for_new_repositories = optional(bool)
  })
  nullable = true
  default  = null
}

variable "webhooks" {
  description = "List of webhooks."
  type = list(object({
    events = set(string)
    configuration = object({
      url          = string
      content_type = string
      secret       = optional(string)
      insecure_ssl = optional(bool)
    })
    active = optional(bool)
    name   = optional(string)
  }))
  default = []
}

# Users and Teams
# ============================================================================
variable "custom_roles" {
  description = "Custom roles."
  type = list(object({
    name        = string
    description = optional(string)
    base_role   = string
    permissions = set(string)
  }))
  default = []
}

variable "blocks" {
  description = "List of users to block."
  type        = set(string)
  default     = []
}

# NOTE: Forwarded variable
variable "teams" {
  type = list(object({
    name                      = string
    description               = optional(string)
    privacy                   = optional(string)
    parent_team_id            = optional(string)
    ldap_dn                   = optional(string)
    create_default_maintainer = optional(bool)
    settings = optional(object({
      review_request_delegation = optional(object({
        algorithm    = optional(string)
        member_count = optional(number)
        notify       = optional(bool)
      }))
    }))
    is_security_manager = optional(bool)
    members = optional(list(object({
      username = string
      role     = optional(string)
    })))
    members_authoritative = optional(bool)
    repositories = optional(list(object({
      repository = string
      permission = optional(string)
    })))
    sync_group_mapping = optional(object({
      groups = optional(list(object({
        group_id          = string
        group_name        = string
        group_description = string
      })))
    }))
  }))
}

# Repositories
# ============================================================================
variable "app_installations" {
  description = "List of relationships between app installations and repositories."
  type = list(object({
    installation_id       = string
    selected_repositories = set(string)
  }))
  default = []
}

# NOTE: Forwarded variable
variable "secrets" {
  description = <<-EOT
GitHub Actions secrets for this organization.

- Available values for `subject` are `"actions"`, `"codespaces"`, `"dependabot"`.
- `github_actions_environment_secret` resource will be created if `environment` key specified.
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

# NOTE: Forwarded variable
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

# NOTE: Forwarded variable
variable "rulesets" {
  description = "Repository rulesets."
  type = list(object({
    enforcement = string
    name        = string
    rules = object({
      branch_name_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      commit_author_email_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      commit_message_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      committer_email_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      creation         = optional(bool)
      deletion         = optional(bool)
      non_fast_forward = optional(bool)
      pull_request = optional(object({
        dismiss_stale_reviews_on_push     = optional(bool)
        require_code_owner_review         = optional(bool)
        require_last_push_approval        = optional(bool)
        required_approving_review_count   = optional(number)
        required_review_thread_resolution = optional(bool)
      }))
      required_linear_history = optional(bool)
      required_signatures     = optional(bool)
      required_status_checks = optional(object({
        required_check = list(object({
          context        = string
          integration_id = optional(number)
        }))
        strict_required_status_checks_policy = optional(bool)
      }))
      required_workflows = optional(object({
        required_workflow = object({
          repository_id = number
          path          = string
          ref           = optional(string)
        })
      }))
      tag_name_pattern = optional(object({
        operator = string
        pattern  = string
        name     = optional(string)
        negate   = optional(bool)
      }))
      update                        = optional(bool)
      update_allows_fetch_and_merge = optional(bool)
    })
    target = string
    bypass_actors = optional(list(object({
      actor_id    = number
      actor_type  = string
      bypass_mode = optional(string)
    })))
    conditions = optional(object({
      ref_name = object({
        exclude = set(string)
        include = set(string)
      })
    }))
  }))
  default = []
}

# GitHub Actions
# ============================================================================
# NOTE: Forwarded variable
variable "actions_organization_permissions" {
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

# NOTE: Forwarded variable
variable "actions_oidc_subject_claim_customization_template" {
  description = "A list of OpenID Connect claims."
  type = object({
    include_claim_keys = set(string)
  })
  nullable = true
  default  = null
}

# NOTE: Forwarded variable
variable "actions_runner_groups" {
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

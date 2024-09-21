resource "github_actions_organization_permissions" "this" {
  count = var.create && var.organization_permissions != null ? 1 : 0

  allowed_actions      = try(var.organization_permissions.allowed_actions, null)
  enabled_repositories = try(var.organization_permissions.enabled_repositories, null)

  dynamic "allowed_actions_config" {
    for_each = var.organization_permissions.allowed_actions_config != null ? [var.organization_permissions.allowed_actions_config] : []

    content {
      github_owned_allowed = allowed_actions_config.value.github_owned_allowed
      patterns_allowed     = try(allowed_actions_config.value.patterns_allowed, null)
      verified_allowed     = try(allowed_actions_config.value.verified_allowed, null)
    }
  }

  dynamic "enabled_repositories_config" {
    for_each = var.organization_permissions.enabled_repositories_config != null ? [var.organization_permissions.enabled_repositories_config] : []

    content {
      repository_ids = enabled_repositories_config.value.repository_ids
    }
  }
}

resource "github_actions_organization_oidc_subject_claim_customization_template" "this" {
  count = var.create && var.oidc_subject_claim_customization_template != null ? 1 : 0

  include_claim_keys = var.oidc_subject_claim_customization_template.include_claim_keys
}

resource "github_actions_runner_group" "this" {
  for_each = { for v in var.runner_groups : v.name => v if var.create }

  name                       = each.value.name
  restricted_to_workflows    = try(each.value.restricted_to_workflows, null)
  selected_repository_ids    = try(each.value.selected_repository_ids, null)
  selected_workflows         = try(each.value.selected_workflows, null)
  visibility                 = try(each.value.visibility, null)
  allows_public_repositories = try(each.value.allows_public_repositories, null)
}

module "secrets_and_variables" {
  source = "../secrets-and-variables"

  secrets   = [for v in var.secrets : merge(v, { subjects = ["actions"] })]
  variables = var.variables
}

# NOTE: A GitHub organization cannot be created via Terraform

resource "github_organization_settings" "this" {
  count = var.create ? 1 : 0

  billing_email                                                = var.settings.billing_email
  company                                                      = try(var.settings.company, null)
  blog                                                         = try(var.settings.blog, null)
  email                                                        = try(var.settings.email, null)
  twitter_username                                             = try(var.settings.twitter_username, null)
  location                                                     = try(var.settings.location, null)
  name                                                         = try(var.settings.name, null)
  description                                                  = try(var.settings.description, null)
  has_organization_projects                                    = try(var.settings.has_organization_projects, null)
  has_repository_projects                                      = try(var.settings.has_repository_projects, null)
  default_repository_permission                                = try(var.settings.default_repository_permission, null)
  members_can_create_repositories                              = try(var.settings.members_can_create_repositories, null)
  members_can_create_public_repositories                       = try(var.settings.members_can_create_public_repositories, null)
  members_can_create_private_repositories                      = try(var.settings.members_can_create_private_repositories, null)
  members_can_create_internal_repositories                     = try(var.settings.members_can_create_internal_repositories, null)
  members_can_create_pages                                     = try(var.settings.members_can_create_pages, null)
  members_can_create_public_pages                              = try(var.settings.members_can_create_public_pages, null)
  members_can_create_private_pages                             = try(var.settings.members_can_create_private_pages, null)
  members_can_fork_private_repositories                        = try(var.settings.members_can_fork_private_repositories, null)
  web_commit_signoff_required                                  = try(var.settings.web_commit_signoff_required, null)
  advanced_security_enabled_for_new_repositories               = try(var.settings.advanced_security_enabled_for_new_repositories, null)
  dependabot_alerts_enabled_for_new_repositories               = try(var.settings.dependabot_alerts_enabled_for_new_repositories, null)
  dependabot_security_updates_enabled_for_new_repositories     = try(var.settings.dependabot_security_updates_enabled_for_new_repositories, null)
  dependency_graph_enabled_for_new_repositories                = try(var.settings.dependency_graph_enabled_for_new_repositories, null)
  secret_scanning_enabled_for_new_repositories                 = try(var.settings.secret_scanning_enabled_for_new_repositories, null)
  secret_scanning_push_protection_enabled_for_new_repositories = try(var.settings.secret_scanning_push_protection_enabled_for_new_repositories, null)
}

resource "github_organization_webhook" "this" {
  for_each = { for index, v in var.webhooks : index => v if var.create }

  events = each.value.events

  dynamic "configuration" {
    for_each = [each.value.configuration]

    content {
      url          = configuration.value.url
      content_type = configuration.value.content_type
      secret       = try(configuration.value.secret, null)
      insecure_ssl = try(configuration.value.insecure_ssl, null)
    }
  }

  active = try(each.value.active, null)

  # FIXME: In documentation but not supported
  # name   = try(each.value.name, null)
}

# Users and Teams
# ============================================================================
resource "github_organization_custom_role" "this" {
  for_each = { for role_def in var.custom_roles : role_def.name => role_def if var.create }

  name        = each.value.name
  description = try(each.value.description, null)
  base_role   = each.value.base_role
  permissions = each.value.permissions
}

resource "github_organization_block" "this" {
  for_each = { for index, v in var.blocks : index => v if var.create }

  username = each.value
}

module "teams" {
  source   = "./modules/team"
  for_each = { for team in var.teams : team.name => team }

  name                      = each.value.name
  description               = try(each.value.description, null)
  privacy                   = try(each.value.privacy, null)
  parent_team_id            = try(each.value.parent_team_id, null)
  ldap_dn                   = try(each.value.ldap_dn, null)
  create_default_maintainer = try(each.value.create_default_maintainer, null)
  settings                  = try(each.value.settings, null)
  is_security_manager       = try(each.value.is_security_manager, null)
  members                   = try(each.value.members, null)
  members_authoritative     = try(each.value.members_authoritative, null)
  repositories              = try(each.value.repositories, null)
  sync_group_mapping        = try(each.value.sync_group_mapping, null)
}

# Repositories
# ============================================================================
resource "github_app_installation_repositories" "this" {
  for_each = { for index, v in var.app_installations : index => v if var.create }

  installation_id       = each.value.installation_id
  selected_repositories = each.value.selected_repositories
}

module "secrets_and_variables" {
  source = "./modules/secrets-and-variables"
  count  = var.create ? 1 : 0

  secrets   = var.secrets
  variables = var.variables
}

module "rulesets" {
  source = "./modules/rulesets"
  count  = var.create ? 1 : 0

  rulesets = var.rulesets
}

# GitHub Actions
# ============================================================================
module "actions" {
  source = "./modules/actions"
  count  = var.create ? 1 : 0

  organization_permissions                  = var.actions_organization_permissions
  oidc_subject_claim_customization_template = var.actions_oidc_subject_claim_customization_template
  runner_groups                             = var.actions_runner_groups
}

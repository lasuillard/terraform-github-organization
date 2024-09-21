output "permissions" {
  description = "Actions repository permissions."
  value       = try(github_actions_organization_permissions.this[0], null)
}

output "oidc_subject_claim_customization_template" {
  description = "Actions OIDC subject claim customization template."
  value       = try(github_actions_organization_oidc_subject_claim_customization_template.this[0], null)
}

output "runner_groups" {
  description = "Actions runner groups."
  value       = try(github_actions_runner_group.this, {})
}

output "secrets_and_variables" {
  description = "Actions secrets and variables."
  value       = module.secrets_and_variables
}

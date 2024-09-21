output "settings" {
  description = "Organization settings."
  value       = try(github_organization_settings.this[0], null)
}

output "webhooks" {
  description = "Repository webhooks."
  value = [
    for e in github_organization_webhook.this :
    {
      repository = e.repository
      events     = e.events
      configuration = {
        content_type = e.configuration[0].content_type
        insecure_ssl = e.configuration[0].insecure_ssl
      }
      active = e.active
      name   = e.name
    }
  ]
}

output "custom_roles" {
  description = "Custom roles."
  value       = github_organization_custom_role.this
}

output "blocks" {
  description = "Organization blocks."
  value       = github_organization_block.this
}

output "teams" {
  description = "Organization teams."
  value       = module.teams
}

output "app_installations" {
  description = "GitHub App installations."
  value       = github_app_installation_repositories.this
}

output "secrets_and_variables" {
  description = "Repository Actions, Codespaces and Dependabot secrets and variables."
  value       = module.secrets_and_variables
}

output "rulesets" {
  description = "Repository rulesets."
  value       = module.rulesets
}

output "actions" {
  description = "GitHub Actions module outputs."
  value       = module.actions
}

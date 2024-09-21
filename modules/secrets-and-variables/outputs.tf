locals {
  secrets_exclude_keys = ["plaintext_value", "encrypted_value"]
}

output "actions_secrets" {
  description = "Actions secrets."
  value = [
    for e in github_actions_organization_secret.this :
    { for k, v in e : k => v if !contains(local.secrets_exclude_keys, k) }
  ]
}

output "actions_variables" {
  description = "Actions variables."
  value       = github_actions_organization_variable.this
}

output "codespaces_secrets" {
  description = "Codespaces secrets."
  value = [
    for e in github_codespaces_organization_secret.this :
    { for k, v in e : k => v if !contains(local.secrets_exclude_keys, k) }
  ]
}

output "dependabot_secrets" {
  description = "Dependabot secrets."
  value = [
    for e in github_dependabot_organization_secret.this :
    { for k, v in e : k => v if !contains(local.secrets_exclude_keys, k) }
  ]
}

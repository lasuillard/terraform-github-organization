output "team" {
  description = "Team resource."
  value       = try(github_team.this[0], null)
}

output "settings" {
  description = "Team settings."
  value       = try(github_team_settings.this[0], null)
}

output "members" {
  description = "Team members."
  value       = try(github_team_membership.this, github_team_members.this[0], null)
}

output "repositories" {
  description = "Team repositories."
  value       = try(github_team_repository.this, null)
}

output "sync_group_mapping" {
  description = "Team sync group mapping."
  value       = try(github_team_sync_group_mapping.this[0], null)
}

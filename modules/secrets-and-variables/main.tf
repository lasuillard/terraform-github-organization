resource "github_actions_organization_secret" "this" {
  for_each = {
    for v in var.secrets : v.secret_name => v
    if var.create && contains(v.subjects, "actions") && v.environment == null
  }

  secret_name             = each.value.secret_name
  encrypted_value         = try(each.value.encrypted_value, null)
  plaintext_value         = try(each.value.plaintext_value, null)
  visibility              = each.value.visibility
  selected_repository_ids = try(each.value.selected_repository_ids, null)
}

resource "github_actions_organization_variable" "this" {
  for_each = {
    for v in var.variables : v.variable_name => v
    if var.create && v.environment == null
  }

  variable_name           = each.value.variable_name
  value                   = each.value.value
  visibility              = each.value.visibility
  selected_repository_ids = try(each.value.selected_repository_ids, null)
}

resource "github_codespaces_organization_secret" "this" {
  for_each = {
    for v in var.secrets : v.secret_name => v
    if var.create && contains(v.subjects, "codespaces")
  }

  secret_name             = each.value.secret_name
  encrypted_value         = try(each.value.encrypted_value, null)
  plaintext_value         = try(each.value.plaintext_value, null)
  visibility              = each.value.visibility
  selected_repository_ids = try(each.value.selected_repository_ids, null)
}

resource "github_dependabot_organization_secret" "this" {
  for_each = {
    for v in var.secrets : v.secret_name => v
    if var.create && contains(v.subjects, "dependabot")
  }

  secret_name             = each.value.secret_name
  encrypted_value         = try(each.value.encrypted_value, null)
  plaintext_value         = try(each.value.plaintext_value, null)
  visibility              = each.value.visibility
  selected_repository_ids = try(each.value.selected_repository_ids, null)
}

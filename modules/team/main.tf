resource "github_team" "this" {
  count = var.create ? 1 : 0

  name                      = var.name
  description               = try(var.description, null)
  privacy                   = try(var.privacy, null)
  parent_team_id            = try(var.parent_team_id, null)
  ldap_dn                   = try(var.ldap_dn, null)
  create_default_maintainer = try(var.create_default_maintainer, null)
}

resource "github_team_settings" "this" {
  count = var.create ? 1 : 0

  team_id = github_team.this[0].id

  dynamic "review_request_delegation" {
    for_each = var.settings.review_request_delegation != null ? [var.settings.review_request_delegation] : []

    content {
      algorithm    = try(review_request_delegation.value.algorithm, null)
      member_count = try(review_request_delegation.value.member_count, null)
      notify       = try(review_request_delegation.value.notify, null)
    }
  }
}

resource "github_team_membership" "this" {
  for_each = {
    for index, v in var.members_authoritative ? [] : var.members :
    index => v
  }

  team_id  = github_team.this[0].id
  username = each.value.username
  role     = try(each.value.role, null)
}

resource "github_team_members" "this" {
  count = var.members_authoritative ? 1 : 0

  team_id = github_team.this[0].id

  dynamic "members" {
    for_each = var.members

    content {
      username = members.value.username
      role     = try(members.value.role, null)
    }
  }
}

resource "github_team_repository" "this" {
  for_each = { for k in var.repositories : k.repository => k if var.create }

  team_id    = github_team.this[0].id
  repository = each.value.repository
  permission = try(each.value.permission, null)
}

resource "github_team_sync_group_mapping" "this" {
  count = var.create && var.sync_group_mapping != null ? 1 : 0

  team_slug = github_team.this[0].slug

  dynamic "group" {
    for_each = var.sync_group_mapping.groups != null ? var.sync_group_mapping.groups : []

    content {
      group_id          = group.value.group_id
      group_name        = group.value.group_name
      group_description = group.value.group_description
    }
  }
}

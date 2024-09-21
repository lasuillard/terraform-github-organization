# secrets-and-variables

Submodule for creating GitHub Actions variables and secrets for Actions, Codespaces and Dependabot.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_organization_security_manager.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_security_manager) | resource |
| [github_team.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team) | resource |
| [github_team_members.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_members) | resource |
| [github_team_membership.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_membership) | resource |
| [github_team_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_repository) | resource |
| [github_team_settings.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_settings) | resource |
| [github_team_sync_group_mapping.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/team_sync_group_mapping) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create this module or not. | `bool` | `true` | no |
| <a name="input_create_default_maintainer"></a> [create\_default\_maintainer](#input\_create\_default\_maintainer) | Adds a default maintainer to the team. Defaults to false and adds the creating user to the team when true. | `bool` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of the team. | `string` | n/a | yes |
| <a name="input_is_security_manager"></a> [is\_security\_manager](#input\_is\_security\_manager) | Whether to add the team as a security manager. | `bool` | `false` | no |
| <a name="input_ldap_dn"></a> [ldap\_dn](#input\_ldap\_dn) | The LDAP Distinguished Name of the group where membership will be synchronized. Only available in GitHub Enterprise Server. | `string` | `null` | no |
| <a name="input_members"></a> [members](#input\_members) | A list of members to add to the team. | <pre>list(object({<br/>    username = string<br/>    role     = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_members_authoritative"></a> [members\_authoritative](#input\_members\_authoritative) | Whether the members list is authoritative. If true, only the members in the list will be in the team. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the team. | `string` | n/a | yes |
| <a name="input_parent_team_id"></a> [parent\_team\_id](#input\_parent\_team\_id) | The ID or slug of the parent team, if this is a nested team. | `string` | `null` | no |
| <a name="input_privacy"></a> [privacy](#input\_privacy) | The level of privacy for the team. Must be one of `secret` or `closed`. | `string` | `null` | no |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | A list of repositories to add to the team. | <pre>list(object({<br/>    repository = string<br/>    permission = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | Settings for the team. | <pre>object({<br/>    review_request_delegation = optional(object({<br/>      algorithm    = optional(string)<br/>      member_count = optional(number)<br/>      notify       = optional(bool)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_sync_group_mapping"></a> [sync\_group\_mapping](#input\_sync\_group\_mapping) | Identity Provider (IdP) group connections within your GitHub teams. You must have team synchronization enabled for organizations owned by enterprise accounts. | <pre>object({<br/>    groups = optional(list(object({<br/>      group_id          = string<br/>      group_name        = string<br/>      group_description = string<br/>    })))<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_members"></a> [members](#output\_members) | Team members. |
| <a name="output_repositories"></a> [repositories](#output\_repositories) | Team repositories. |
| <a name="output_settings"></a> [settings](#output\_settings) | Team settings. |
| <a name="output_sync_group_mapping"></a> [sync\_group\_mapping](#output\_sync\_group\_mapping) | Team sync group mapping. |
| <a name="output_team"></a> [team](#output\_team) | Team resource. |
<!-- END_TF_DOCS -->

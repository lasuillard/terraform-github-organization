# actions

Submodule for managing GitHub Actions settings, secrets and variables.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 6.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secrets_and_variables"></a> [secrets\_and\_variables](#module\_secrets\_and\_variables) | ../secrets-and-variables | n/a |

## Resources

| Name | Type |
|------|------|
| [github_actions_organization_oidc_subject_claim_customization_template.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_oidc_subject_claim_customization_template) | resource |
| [github_actions_organization_permissions.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_organization_permissions) | resource |
| [github_actions_runner_group.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_runner_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create this module or not. | `bool` | `true` | no |
| <a name="input_oidc_subject_claim_customization_template"></a> [oidc\_subject\_claim\_customization\_template](#input\_oidc\_subject\_claim\_customization\_template) | A list of OpenID Connect claims. | <pre>object({<br/>    include_claim_keys = set(string)<br/>  })</pre> | `null` | no |
| <a name="input_organization_permissions"></a> [organization\_permissions](#input\_organization\_permissions) | GitHub Actions permissions for current organization. | <pre>object({<br/>    allowed_actions      = optional(string)<br/>    enabled_repositories = optional(string)<br/>    allowed_actions_config = optional(object({<br/>      github_owned_allowed = bool<br/>      patterns_allowed     = optional(set(string))<br/>      verified_allowed     = optional(bool)<br/>    }))<br/>    enabled_repositories_config = optional(object({<br/>      repository_ids = set(number)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_runner_groups"></a> [runner\_groups](#input\_runner\_groups) | GitHub Actions runner groups for this organization. | <pre>list(object({<br/>    name                       = string<br/>    restricted_to_workflows    = optional(bool)<br/>    selected_repository_ids    = optional(set(number))<br/>    selected_workflows         = optional(set(string))<br/>    visibility                 = optional(string)<br/>    allows_public_repositories = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | GitHub Actions secrets for this organization. | <pre>list(object({<br/>    subjects                = set(string)<br/>    secret_name             = string<br/>    encrypted_value         = optional(string)<br/>    plaintext_value         = optional(string)<br/>    visibility              = string<br/>    selected_repository_ids = optional(set(number))<br/>  }))</pre> | `[]` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | GitHub Actions variables for this organization. | <pre>list(object({<br/>    variable_name           = string<br/>    value                   = optional(string)<br/>    visibility              = string<br/>    selected_repository_ids = optional(set(number))<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_oidc_subject_claim_customization_template"></a> [oidc\_subject\_claim\_customization\_template](#output\_oidc\_subject\_claim\_customization\_template) | Actions OIDC subject claim customization template. |
| <a name="output_permissions"></a> [permissions](#output\_permissions) | Actions repository permissions. |
| <a name="output_runner_groups"></a> [runner\_groups](#output\_runner\_groups) | Actions runner groups. |
| <a name="output_secrets_and_variables"></a> [secrets\_and\_variables](#output\_secrets\_and\_variables) | Actions secrets and variables. |
<!-- END_TF_DOCS -->

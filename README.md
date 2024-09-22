# terraform-github-organization

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![CI](https://github.com/lasuillard/terraform-github-organization/actions/workflows/ci.yaml/badge.svg)](https://github.com/lasuillard/terraform-github-organization/actions/workflows/ci.yaml)
![GitHub Release](https://img.shields.io/github/v/release/lasuillard/terraform-github-organization)

Terraform module to create GitHub organization relevant resources.

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
| <a name="module_actions"></a> [actions](#module\_actions) | ./modules/actions | n/a |
| <a name="module_rulesets"></a> [rulesets](#module\_rulesets) | ./modules/rulesets | n/a |
| <a name="module_secrets_and_variables"></a> [secrets\_and\_variables](#module\_secrets\_and\_variables) | ./modules/secrets-and-variables | n/a |
| <a name="module_teams"></a> [teams](#module\_teams) | ./modules/team | n/a |

## Resources

| Name | Type |
|------|------|
| [github_app_installation_repositories.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/app_installation_repositories) | resource |
| [github_organization_block.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_block) | resource |
| [github_organization_custom_role.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_custom_role) | resource |
| [github_organization_settings.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_settings) | resource |
| [github_organization_webhook.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/organization_webhook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions_oidc_subject_claim_customization_template"></a> [actions\_oidc\_subject\_claim\_customization\_template](#input\_actions\_oidc\_subject\_claim\_customization\_template) | A list of OpenID Connect claims. | <pre>object({<br/>    include_claim_keys = set(string)<br/>  })</pre> | `null` | no |
| <a name="input_actions_organization_permissions"></a> [actions\_organization\_permissions](#input\_actions\_organization\_permissions) | GitHub Actions permissions for current organization. | <pre>object({<br/>    allowed_actions      = optional(string)<br/>    enabled_repositories = optional(string)<br/>    allowed_actions_config = optional(object({<br/>      github_owned_allowed = bool<br/>      patterns_allowed     = optional(set(string))<br/>      verified_allowed     = optional(bool)<br/>    }))<br/>    enabled_repositories_config = optional(object({<br/>      repository_ids = set(number)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_actions_runner_groups"></a> [actions\_runner\_groups](#input\_actions\_runner\_groups) | GitHub Actions runner groups for this organization. | <pre>list(object({<br/>    name                       = string<br/>    restricted_to_workflows    = optional(bool)<br/>    selected_repository_ids    = optional(set(number))<br/>    selected_workflows         = optional(set(string))<br/>    visibility                 = optional(string)<br/>    allows_public_repositories = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_app_installations"></a> [app\_installations](#input\_app\_installations) | List of relationships between app installations and repositories. | <pre>list(object({<br/>    installation_id       = string<br/>    selected_repositories = set(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_blocks"></a> [blocks](#input\_blocks) | List of users to block. | `set(string)` | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create this module or not. | `bool` | `true` | no |
| <a name="input_custom_roles"></a> [custom\_roles](#input\_custom\_roles) | Custom roles. | <pre>list(object({<br/>    name        = string<br/>    description = optional(string)<br/>    base_role   = string<br/>    permissions = set(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_rulesets"></a> [rulesets](#input\_rulesets) | Repository rulesets. | <pre>list(object({<br/>    enforcement = string<br/>    name        = string<br/>    rules = object({<br/>      branch_name_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      commit_author_email_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      commit_message_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      committer_email_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      creation         = optional(bool)<br/>      deletion         = optional(bool)<br/>      non_fast_forward = optional(bool)<br/>      pull_request = optional(object({<br/>        dismiss_stale_reviews_on_push     = optional(bool)<br/>        require_code_owner_review         = optional(bool)<br/>        require_last_push_approval        = optional(bool)<br/>        required_approving_review_count   = optional(number)<br/>        required_review_thread_resolution = optional(bool)<br/>      }))<br/>      required_linear_history = optional(bool)<br/>      required_signatures     = optional(bool)<br/>      required_status_checks = optional(object({<br/>        required_check = list(object({<br/>          context        = string<br/>          integration_id = optional(number)<br/>        }))<br/>        strict_required_status_checks_policy = optional(bool)<br/>      }))<br/>      required_workflows = optional(object({<br/>        required_workflow = object({<br/>          repository_id = number<br/>          path          = string<br/>          ref           = optional(string)<br/>        })<br/>      }))<br/>      tag_name_pattern = optional(object({<br/>        operator = string<br/>        pattern  = string<br/>        name     = optional(string)<br/>        negate   = optional(bool)<br/>      }))<br/>      update                        = optional(bool)<br/>      update_allows_fetch_and_merge = optional(bool)<br/>    })<br/>    target = string<br/>    bypass_actors = optional(list(object({<br/>      actor_id    = number<br/>      actor_type  = string<br/>      bypass_mode = optional(string)<br/>    })))<br/>    conditions = optional(object({<br/>      ref_name = object({<br/>        exclude = set(string)<br/>        include = set(string)<br/>      })<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | GitHub Actions secrets for this organization.<br/><br/>- Available values for `subject` are `"actions"`, `"codespaces"`, `"dependabot"`. | <pre>list(object({<br/>    subjects                = set(string)<br/>    secret_name             = string<br/>    encrypted_value         = optional(string)<br/>    plaintext_value         = optional(string)<br/>    visibility              = string<br/>    selected_repository_ids = optional(set(number))<br/>  }))</pre> | `[]` | no |
| <a name="input_settings"></a> [settings](#input\_settings) | Organization settings. | <pre>object({<br/>    billing_email                                                = string<br/>    company                                                      = string<br/>    blog                                                         = string<br/>    email                                                        = string<br/>    twitter_username                                             = string<br/>    location                                                     = string<br/>    name                                                         = string<br/>    description                                                  = string<br/>    has_organization_projects                                    = optional(bool)<br/>    has_repository_projects                                      = optional(bool)<br/>    default_repository_permission                                = optional(string)<br/>    members_can_create_repositories                              = optional(bool)<br/>    members_can_create_public_repositories                       = optional(bool)<br/>    members_can_create_private_repositories                      = optional(bool)<br/>    members_can_create_internal_repositories                     = optional(bool)<br/>    members_can_create_pages                                     = optional(bool)<br/>    members_can_create_public_pages                              = optional(bool)<br/>    members_can_create_private_pages                             = optional(bool)<br/>    members_can_fork_private_repositories                        = optional(bool)<br/>    web_commit_signoff_required                                  = optional(bool)<br/>    advanced_security_enabled_for_new_repositories               = optional(bool)<br/>    dependabot_alerts_enabled_for_new_repositories               = optional(bool)<br/>    dependabot_security_updates_enabled_for_new_repositories     = optional(bool)<br/>    dependency_graph_enabled_for_new_repositories                = optional(bool)<br/>    secret_scanning_enabled_for_new_repositories                 = optional(bool)<br/>    secret_scanning_push_protection_enabled_for_new_repositories = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_teams"></a> [teams](#input\_teams) | NOTE: Forwarded variable | <pre>list(object({<br/>    name                      = string<br/>    description               = optional(string)<br/>    privacy                   = optional(string)<br/>    parent_team_id            = optional(string)<br/>    ldap_dn                   = optional(string)<br/>    create_default_maintainer = optional(bool)<br/>    settings = optional(object({<br/>      review_request_delegation = optional(object({<br/>        algorithm    = optional(string)<br/>        member_count = optional(number)<br/>        notify       = optional(bool)<br/>      }))<br/>    }))<br/>    is_security_manager = optional(bool)<br/>    members = optional(list(object({<br/>      username = string<br/>      role     = optional(string)<br/>    })))<br/>    members_authoritative = optional(bool)<br/>    repositories = optional(list(object({<br/>      repository = string<br/>      permission = optional(string)<br/>    })))<br/>    sync_group_mapping = optional(object({<br/>      groups = optional(list(object({<br/>        group_id          = string<br/>        group_name        = string<br/>        group_description = string<br/>      })))<br/>    }))<br/>  }))</pre> | `null` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | GitHub Actions variables for this organization. | <pre>list(object({<br/>    variable_name           = string<br/>    value                   = optional(string)<br/>    visibility              = string<br/>    selected_repository_ids = optional(set(number))<br/>  }))</pre> | `[]` | no |
| <a name="input_webhooks"></a> [webhooks](#input\_webhooks) | List of webhooks. | <pre>list(object({<br/>    events = set(string)<br/>    configuration = object({<br/>      url          = string<br/>      content_type = string<br/>      secret       = optional(string)<br/>      insecure_ssl = optional(bool)<br/>    })<br/>    active = optional(bool)<br/>    name   = optional(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_actions"></a> [actions](#output\_actions) | GitHub Actions module outputs. |
| <a name="output_app_installations"></a> [app\_installations](#output\_app\_installations) | GitHub App installations. |
| <a name="output_blocks"></a> [blocks](#output\_blocks) | Organization blocks. |
| <a name="output_custom_roles"></a> [custom\_roles](#output\_custom\_roles) | Custom roles. |
| <a name="output_rulesets"></a> [rulesets](#output\_rulesets) | Repository rulesets. |
| <a name="output_secrets_and_variables"></a> [secrets\_and\_variables](#output\_secrets\_and\_variables) | Repository Actions, Codespaces and Dependabot secrets and variables. |
| <a name="output_settings"></a> [settings](#output\_settings) | Organization settings. |
| <a name="output_teams"></a> [teams](#output\_teams) | Organization teams. |
| <a name="output_webhooks"></a> [webhooks](#output\_webhooks) | Repository webhooks. |
<!-- END_TF_DOCS -->

provider "github" {
  token = var.github_token
}

module "complete" {
  source = "../../"

  create = var.create
  settings = {
    billing_email                                                = "billing@example.com"
    company                                                      = "Example Company"
    blog                                                         = "https://blog.example.com"
    email                                                        = "contact@example.com"
    twitter_username                                             = "example_twitter"
    location                                                     = "Example City"
    name                                                         = "Example Organization"
    description                                                  = "This is an example organization."
    has_organization_projects                                    = true
    has_repository_projects                                      = true
    default_repository_permission                                = "read"
    members_can_create_repositories                              = true
    members_can_create_public_repositories                       = true
    members_can_create_private_repositories                      = true
    members_can_create_internal_repositories                     = true
    members_can_create_pages                                     = true
    members_can_create_public_pages                              = true
    members_can_create_private_pages                             = true
    members_can_fork_private_repositories                        = true
    web_commit_signoff_required                                  = false
    advanced_security_enabled_for_new_repositories               = true
    dependabot_alerts_enabled_for_new_repositories               = true
    dependabot_security_updates_enabled_for_new_repositories     = true
    dependency_graph_enabled_for_new_repositories                = true
    secret_scanning_enabled_for_new_repositories                 = true
    secret_scanning_push_protection_enabled_for_new_repositories = true
  }

  webhooks = [
    {
      events = ["issue_comment"]
      configuration = {
        url          = "https://some.webhook.url/path/to/receiver"
        content_type = "json"
        secret       = "some-secret"
        insecure_ssl = false
      }
      active = true
    }
  ]

  custom_roles = [
    {
      name        = "custom_role_example"
      description = "This is an example custom role."
      base_role   = "read"
      permissions = ["pull", "issues"]
    }
  ]

  blocks = ["blocked-username"]

  teams = [
    {
      name                      = "example_team"
      description               = "This is an example team."
      privacy                   = "closed"
      parent_team_id            = null
      ldap_dn                   = null
      create_default_maintainer = false
      settings = {
        review_request_delegation = {
          algorithm    = "ROUND_ROBIN"
          member_count = 2
          notify       = true
        }
      }
      is_security_manager = false
      members = [
        {
          username = "example_user"
          role     = "member"
        }
      ]
      members_authoritative = false
      repositories = [
        {
          repository = "example_repo"
          permission = "admin"
        }
      ]
      sync_group_mapping = {
        groups = [
          {
            group_id          = "12345"
            group_name        = "example_group"
            group_description = "This is an example group."
          }
        ]
      }
    }
  ]

  app_installations = [
    {
      installation_id       = 12345
      selected_repositories = ["example_repo"]
    }
  ]
  secrets = [
    {
      subjects                = ["actions"]
      secret_name             = "example_secret"
      encrypted_value         = "encrypted_value_here"
      visibility              = "selected"
      selected_repository_ids = [123456]
    }
  ]

  variables = [
    {
      variable_name           = "example_variable"
      value                   = "example_value"
      visibility              = "all"
      selected_repository_ids = null
    }
  ]

  rulesets = [
    {
      enforcement = "active"
      name        = "example_ruleset"
      rules = {
        branch_name_pattern = {
          operator = "starts_with"
          pattern  = "feature/"
          name     = "Branch name pattern"
          negate   = false
        }
        commit_author_email_pattern = {
          operator = "contains"
          pattern  = "@example.com"
          name     = "Commit author email pattern"
          negate   = false
        }
        commit_message_pattern = {
          operator = "regex"
          pattern  = "^(feat|fix|docs|style|refactor|perf|test|chore)(\\(.*\\))?: .{1,50}"
          name     = "Commit message pattern"
          negate   = true
        }
        committer_email_pattern = {
          operator = "ends_with"
          pattern  = "@example.com"
          name     = "Committer email pattern"
          negate   = false
        }
        creation         = true
        deletion         = false
        non_fast_forward = true
        pull_request = {
          dismiss_stale_reviews_on_push     = true
          require_code_owner_review         = true
          require_last_push_approval        = false
          required_approving_review_count   = 2
          required_review_thread_resolution = true
        }
        required_linear_history = true
        required_signatures     = true
        required_status_checks = {
          required_check = [
            {
              context        = "ci/circleci"
              integration_id = 123456
            }
          ]
          strict_required_status_checks_policy = true
        }
        required_workflows = {
          required_workflow = {
            repository_id = 123456
            path          = ".github/workflows/ci.yml"
            ref           = "main"
          }
        }
        tag_name_pattern = {
          operator = "matches"
          pattern  = "v[0-9]+.[0-9]+.[0-9]+"
          name     = "Tag name pattern"
          negate   = false
        }
        update                        = true
        update_allows_fetch_and_merge = false
      }
      target = "example_repo"
      bypass_actors = [
        {
          actor_id    = 123456
          actor_type  = "OrganizationAdmin"
          bypass_mode = "always"
        }
      ]
      conditions = {
        ref_name = {
          exclude = ["main"]
          include = ["feature/*"]
        }
      }
    }
  ]

  actions_organization_permissions = {
    allowed_actions      = "all"
    enabled_repositories = "all"
    allowed_actions_config = {
      github_owned_allowed = true
      patterns_allowed     = ["actions/cache@*", "actions/checkout@*"]
      verified_allowed     = true
    }
    enabled_repositories_config = {
      repository_ids = [123456]
    }
  }

  actions_oidc_subject_claim_customization_template = {
    include_claim_keys = ["sub", "aud"]
  }

  actions_runner_groups = [
    {
      name                       = "example_runner_group"
      restricted_to_workflows    = false
      selected_repository_ids    = [123456]
      selected_workflows         = ["ci.yml"]
      visibility                 = "all"
      allows_public_repositories = true
    }
  ]
}

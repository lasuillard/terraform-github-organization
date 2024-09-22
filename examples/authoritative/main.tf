provider "github" {
  token = var.github_token
}

module "authoritative" {
  source = "../../"

  teams = [
    {
      name = "my-team"
      members = [
        {
          username = "octocat"
          role     = "maintainer"
        }
      ]
      members_authoritative = true
    }
  ]
}

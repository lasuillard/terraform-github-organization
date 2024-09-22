provider "github" {
  token = var.github_token
}

module "disabled" {
  source = "../complete"

  github_token = var.github_token
  create       = false
}

provider "github" {
  token = var.github_token
}

module "simple" {
  source = "../../"
}

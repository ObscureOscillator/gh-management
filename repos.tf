module "github_organization_repos" {
  source = "github.com/ObscureOscillator/TerraformModules//modules/github-organization-repos?ref=main"

  repositories = local.org_repos
}
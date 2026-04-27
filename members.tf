module "github_organization_members" {
  source = "github.com/ObscureOscillator/TerraformModules//modules/github-organization-members?ref=main"

  members = {
    for username, config in local.org_members :
    username => {
      role                 = try(config.role, "member")
      downgrade_on_destroy = try(config.downgrade_on_destroy, false)
    }
  }
}
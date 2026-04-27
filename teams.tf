module "github_organization_teams" {
  source = "github.com/ObscureOscillator/TerraformModules//modules/github-organization-teams?ref=main"

  teams = {
    for team_name, config in local.org_teams :
    team_name => {
      description = try(config.description, "")
      privacy     = try(config.privacy, "closed")
      members     = try(config.members, {})
    }
  }
}
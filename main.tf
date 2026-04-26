locals {
  org_members = yamldecode(file("${path.module}/members.yaml")).members
  org_teams   = yamldecode(file("${path.module}/teams.yaml")).teams
}

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

module "github_organization_teams" {
  source = "github.com/ObscureOscillator/TerraformModules//modules/github-organization-teams?ref=feat/add-teams"

  teams = {
    for team_name, config in local.org_teams :
    team_name => {
      description = try(config.description, "")
      privacy     = try(config.privacy, "closed")
      members     = try(config.members, {})
    }
  }
}

module "github_organization" {
  source = "github.com/ObscureOscillator/TerraformModules//modules/github-organization?ref=main"

  organization = {
    billing_email = "me@jaredbloomer.com"
    display_name  = "ObscureOscillator"
    description   = "Github Organization Management Tooling for the ObscureOscillator Organization"

    profile = {
      company          = null
      blog             = null
      email            = null
      location         = null
      twitter_username = null
    }

    projects = {
      has_organization_projects     = true
      has_repository_projects       = true
      default_repository_permission = "read"
    }

    member_permissions = {
      members_can_create_repositories          = true
      members_can_create_public_repositories   = true
      members_can_create_private_repositories  = true
      members_can_create_internal_repositories = false
      members_can_create_pages                 = true
      members_can_create_public_pages          = true
      members_can_create_private_pages         = true
      members_can_fork_private_repositories    = false
      web_commit_signoff_required              = false
    }

    security = {
      advanced_security_enabled_for_new_repositories               = false
      dependabot_alerts_enabled_for_new_repositories               = false
      dependabot_security_updates_enabled_for_new_repositories     = false
      dependency_graph_enabled_for_new_repositories                = false
      secret_scanning_enabled_for_new_repositories                 = false
      secret_scanning_push_protection_enabled_for_new_repositories = false
    }
  }
}

locals {
  org_members = yamldecode(file("${path.module}/members.yaml")).members
  org_teams   = yamldecode(file("${path.module}/teams.yaml")).teams
  org_repos = merge([
    for f in fileset("${path.module}/repos", "*.yaml") :
    yamldecode(file("${path.module}/repos/${f}"))
  ]...)
}

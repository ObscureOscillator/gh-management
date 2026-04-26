# gh-management

Terraform configuration for managing the [ObscureOscillator](https://github.com/ObscureOscillator) GitHub organization. Infrastructure is defined as code using reusable modules from [ObscureOscillator/TerraformModules](https://github.com/ObscureOscillator/TerraformModules).

## What it manages

| Resource | Config file | Module |
|---|---|---|
| Organization settings | `main.tf` | `github-organization` |
| Organization members | `members.yaml` | `github-organization-members` |
| Organization teams | `teams.yaml` | `github-organization-teams` |

## Configuration files

### `members.yaml`

Defines organization membership. Each key is a GitHub username.

```yaml
members:
  username:
    role: member        # "member" or "admin" (default: "member")
```

### `teams.yaml`

Defines organization teams and their membership. Each key is a team name.

```yaml
teams:
  team-name:
    description: "Optional team description"
    privacy: closed     # "closed" or "secret" (default: "closed")
    members:
      username: maintainer  # "member" or "maintainer"
```

## CI/CD

| Workflow | Trigger | Action |
|---|---|---|
| `terraform-plan.yml` | Pull request, manual | Runs `terraform plan` and posts the output as a PR comment |
| `terraform-apply.yml` | Push to `main`, manual | Runs `terraform plan` + `terraform apply` |
| `check-dependencies.yml` | Every Sunday, manual | Runs Renovate to open dependency update PRs |

Changes are applied automatically when a PR is merged to `main`. Renovate is configured to auto-merge minor and patch updates.

## State

Remote state is stored in S3. The backend is configured via environment-level variables injected by the reusable workflow (`AWS_ACCESS_KEY`, `AWS_ACCESS_SECRET`).

## Required secrets

| Secret | Used by |
|---|---|
| `GH_TOKEN` | Terraform GitHub provider authentication |
| `AWS_ACCESS_KEY` | S3 backend access |
| `AWS_ACCESS_SECRET` | S3 backend access |
| `RENOVATE_TOKEN` | Renovate dependency scanning |

## Prerequisites

- Terraform `>= 1.14.9`
- GitHub provider `~> 6.12`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.14.9 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.12 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_github_organization"></a> [github\_organization](#module\_github\_organization) | github.com/ObscureOscillator/TerraformModules//modules/github-organization | main |
| <a name="module_github_organization_members"></a> [github\_organization\_members](#module\_github\_organization\_members) | github.com/ObscureOscillator/TerraformModules//modules/github-organization-members | main |
| <a name="module_github_organization_teams"></a> [github\_organization\_teams](#module\_github\_organization\_teams) | github.com/ObscureOscillator/TerraformModules//modules/github-organization-teams | feat/add-teams |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
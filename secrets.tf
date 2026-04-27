data "aws_ssm_parameter" "secrets" {
  for_each        = local.org_secrets
  name            = each.value.ssm_path
  with_decryption = true
}

module "github_organization_secrets" {
  source = "github.com/ObscureOscillator/TerraformModules//modules/github-organization-secrets?ref=main"

  secrets = {
    for name, config in local.org_secrets :
    name => {
      visibility              = try(config.visibility, "all")
      plaintext_value         = data.aws_ssm_parameter.secrets[name].value
      selected_repository_ids = try(config.selected_repository_ids, [])
    }
  }
}

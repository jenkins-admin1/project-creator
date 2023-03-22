locals {
  _defaults = yamldecode(file(var.defaults_file))
  projects = {
    for f in fileset("${var.data_dir}", "**/*.yaml") :
    trimsuffix(f, ".yaml") => merge(
      yamldecode(file("${var.data_dir}/${f}")),
      local._defaults
    )
  }
}

# Module invocation to public project-factory module.
module "projects" {
  source   = "jenkins-admin1/project-main-module"
  version  = "~> 0.0.1"
  for_each = local.projects

  name              = each.key
  org_id            = each.value.org_id
  billing_account   = each.value.billing_account
  random_project_id = true
  folder_id         = each.value.folder_id
}
/*******************************************
  Create terragrunt Folder under org
 *******************************************/

resource "google_folder" "terragrunt" {
  display_name = "terragrunt_test"
  parent       = var.org_id
}



/*******************************************
  Project creation
 *******************************************/

resource "random_id" "server" {
  byte_length = 3
}


resource "google_project" "seed_project" {
  name                = "terragrunt-seedproject"
  project_id          = "terragrunt-seedproject-${random_id.server.hex}"
  folder_id           = google_folder.terragrunt.name
  billing_account     = var.billing_account
  auto_create_network = "false"
}

resource "google_storage_bucket" "tf_state_bkt" {
  project                     = google_project.seed_project.project_id
  name                        = "terragrunt-iac-core-bkt-${random_id.server.hex}"
  location                    = var.default_region
  force_destroy               = true
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }

}

resource "local_file" "root-vars" {
  content = templatefile("root.yaml.tpl", {
    ROOT_PROJECT = google_project.seed_project.project_id
    GCS_BUCKET   = google_storage_bucket.tf_state_bkt.name
    REGION       = var.default_region
  })
  filename = "../root.yaml"
}


/*************************************************
  Create dev Folder and populate defaults.yaml 
 ************************************************/
resource "google_folder" "dev" {
  display_name = "dev"
  parent       = google_folder.terragrunt.id
}


resource "local_file" "dev-vars" {
  content = templatefile("defaults.yaml.tpl", {
    FOLDER_ID       = google_folder.dev.id
    ORG_ID          = trim(var.org_id, "organizations/")
    BILLING_ACCOUNT = var.billing_account
  })
  filename = "../google/dev/defaults.yaml"
}

/*************************************************
  Create qa Folder and populate defaults.yaml 
 ************************************************/
resource "google_folder" "qa" {
  display_name = "qa"
  parent       = google_folder.terragrunt.id
}

resource "local_file" "qa-vars" {
  content = templatefile("defaults.yaml.tpl", {
    FOLDER_ID       = google_folder.qa.id
    ORG_ID          = trim(var.org_id, "organizations/")
    BILLING_ACCOUNT = var.billing_account
  })
  filename = "../google/qa/defaults.yaml"
}
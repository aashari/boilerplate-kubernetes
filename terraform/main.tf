locals {

  name_prefix   = "${data.google_client_config.main.region}-${var.environment}-"
  resource_name = "${local.name_prefix}${var.service_name}"
  format_name   = "${local.name_prefix}${var.service_name}-{}"

  tags = merge(var.tags, {
    "environment" = var.environment
    "managedby"   = "terraform"
    "name"        = local.resource_name
    "service"     = var.service_name
  })

}

resource "google_service_account" "main" {
  account_id   = data.google_project.main.project_id
  display_name = local.resource_name
}

# allow service account to pull images from container registry
resource "google_project_iam_member" "main-registry" {
  project = data.google_project.main.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.main.email}"
}

# allow service account to manage container clusters
resource "google_project_iam_member" "main-cluster" {
  project = data.google_project.main.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.main.email}"
}

resource "google_container_cluster" "main" {
  name                     = local.resource_name
  location                 = data.google_client_config.main.region
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "main" {
  name       = "${local.resource_name}-pool"
  location   = data.google_client_config.main.region
  cluster    = google_container_cluster.main.name
  node_count = 1

  node_config {
    preemptible     = true
    machine_type    = "e2-small"
    service_account = google_service_account.main.email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

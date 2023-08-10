# get main caller identity
data "google_client_config" "main" {}

# get main active region
data "google_compute_regions" "main" {}

# get main project
data "google_project" "main" {}
resource "google_container_registry" "gke-project-gcr" {
   project  = var.project_id
  location = "US"
}
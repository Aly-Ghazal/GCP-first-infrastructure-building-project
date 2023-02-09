
resource "google_service_account" "node-SA" {
  account_id   = "account-gke-project"
  display_name = "node-sa"
  project = var.project_id_gke
}
resource "google_project_iam_member" "roles-to-sa" {
  #service_account_id = google_service_account.node-SA.name
  #https://cloud.google.com/kubernetes-engine/docs/how-to/iam
  #add-multiple roles:https://stackoverflow.com/questions/61661116/want-to-assign-multiple-google-cloud-iam-roles-to-a-service-account-via-terrafor
  # for_each = toset([
  #   #"roles/iam.serviceAccountUser",
  #   # "roles/container.admin",
  #   # "roles/container.CloudClusterAdmin",
  #   # "roles/container.clusterViewer",
  #   # "roles/container.developer",
  #   #"roles/editor",
  #   #"roles/iam.serviceAccountAdmin",    
  # ])
  role = "roles/storage.objectViewer" #each.value
  member = "serviceAccount:${google_service_account.node-SA.email}"
  project = var.project_id_gke
}

resource "google_container_cluster" "gke-project-cluster" {
  name       = "gke-project-cluster"
  location   = "us-central1-c"
  network    = var.network_id
  subnetwork = var.subnetwork_id
 
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  
  ip_allocation_policy { }
  
  master_auth {
    client_certificate_config {
          issue_client_certificate = false
    }
  }
    
    private_cluster_config {
      enable_private_nodes= true
      enable_private_endpoint = true
      master_ipv4_cidr_block ="172.16.0.0/28"
    }
  
    master_authorized_networks_config {
      cidr_blocks {
        cidr_block = var.authorized_ipv4_cidr_block
        display_name = "External Control Plane access by management subnet"
      }
    }
  
} 


resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "us-central1-c"
  cluster    = google_container_cluster.gke-project-cluster.name
  node_count = 2

  node_config {
    preemptible  = true
    machine_type = var.node-machine-type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.node-SA.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

}
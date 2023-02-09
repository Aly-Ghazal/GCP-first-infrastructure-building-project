resource "google_compute_router" "Router_for_nat" {
  name = "nat-route"
  network = var.network-id-for-route
  region = var.region-of-nat-route
}

resource "google_compute_router_nat" "my-router-nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.Router_for_nat.name
  region                             = google_compute_router.Router_for_nat.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name = var.subnet-to-link-with-nat
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }  
}

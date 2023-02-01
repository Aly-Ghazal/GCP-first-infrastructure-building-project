resource "google_compute_network" "vpc_network" {
  name = var.vpc-name
  auto_create_subnetworks = false
  project = "aly-ahmed-gcp-project"
}


resource "google_compute_subnetwork" "mangement_subnet" {
  name = "mangement-subnet"
  ip_cidr_range = "10.0.0.0/24"
  network       = google_compute_network.vpc_network.id
  stack_type    = var.StackType
  region        = "us-central1"
}

resource "google_compute_subnetwork" "restricted_subnet" {
  name = "restricted-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vpc_network.id
  stack_type    = var.StackType
  region        = "us-central1"
}

resource "google_compute_firewall" "internetAccess" {
  name = "internet-access"
  network = google_compute_network.vpc_network.name
  source_ranges = [google_compute_subnetwork.mangement_subnet.ip_cidr_range]
  allow {
    protocol = var.requiredProtocol
    ports = ["0-65535"]
  }
  allow {
    protocol="udp"
    ports = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "sshAccess" {
  name = "ssh-access"
  network = google_compute_network.vpc_network.name
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = var.requiredProtocol
    ports = ["22"]
  }

}
output "network-id" {
    value = google_compute_network.vpc_network.id
}
output "management-region" {
  value=google_compute_subnetwork.mangement_subnet.region
}
output "mangement-name" {
    value = google_compute_subnetwork.mangement_subnet.name
}
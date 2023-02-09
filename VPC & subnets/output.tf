output "network-id" {
    value = google_compute_network.vpc_network.id
}
output "management-region" {
  value=google_compute_subnetwork.mangement_subnet.region
}
output "mangement-name" {
    value = google_compute_subnetwork.mangement_subnet.name
}
output "vpc_name" {
  value = google_compute_network.vpc_network.name
}
output "restricted_subnet_id" {
  value= google_compute_subnetwork.restricted_subnet.id
}
output "cider_block_of_mangement_subnet" {
  value = google_compute_subnetwork.mangement_subnet.ip_cidr_range
}
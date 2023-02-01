resource "google_compute_instance" "privateInstance" {
  name = var.instance_name
  machine_type =  var.instance_vm_type 
  deletion_protection= false
  zone = var.zone_for_instance
  network_interface {
    network = var.network_name
    subnetwork = var.subnet_name
  }
    boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  service_account {
    scopes = ["cloud-platform"]
  }

}
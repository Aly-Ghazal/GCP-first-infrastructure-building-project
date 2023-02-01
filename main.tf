provider "google" {
  project     = "aly-ahmed-gcp-project"
  region      = "us-central1"
  credentials = file("./aly-ahmed-gcp-project-terraform-cred.json")
}

module "VPC-subnets" {
    source   = "./VPC & subnets"
    vpc-name = "project-vpc"
    StackType= "IPV4_ONLY"
    requiredProtocol ="tcp"
}

module "NAT-part" {
  source = "./NAT gateway"
  network-id-for-route = module.VPC-subnets.network-id
  region-of-nat-route = module.VPC-subnets.management-region
  subnet-to-link-with-nat = module.VPC-subnets.mangement-name
}

module "PrivateVMInstance" {
  source = "./VM private instance"
  instance_name="private-vm"
  instance_vm_type = "e2-micro"
  network_name = module.VPC-subnets.vpc_name
  subnet_name = module.VPC-subnets.mangement-name
  zone_for_instance="us-central1-a"
}

provider "google" {
  project = "sekhar-452813"
  region  = "us-east1"
  zone= "us-east1-b"
}

resource "google_compute_instance" "delegate_vm" {
  name         = "harness-delegate-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network       = "default"
    access_config {} # Adds external IP
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install curl unzip -y
    curl -L "https://app.harness.io/delegate/download?accountIdentifier=ucHySz2jQKKWQweZdXyCog&orgIdentifier=default&projectIdentifier=default_project&token=NTRhYTY0Mjg3NThkNjBiNjMzNzhjOGQyNjEwOTQyZjY=" -o harness-delegate.tar.gz
    tar -zxvf harness-delegate.tar.gz
    cd harness-delegate
    nohup ./start.sh > /tmp/delegate.log 2>&1 &
  EOT

  tags = ["harness-delegate"]
}

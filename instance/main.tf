
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
  exec > /tmp/delegate_install.log 2>&1
  echo "Starting Harness Delegate Installation..."

  apt-get update -y
  apt-get install curl unzip -y

  echo "Downloading Harness Delegate..."
  curl -L "https://app.harness.io/delegate/download?accountIdentifier=ucHySz2jQKKWQweZdXyCog&orgIdentifier=default&projectIdentifier=default_project&token=NTRhYTY0Mjg3NThkNjBiNjMzNzhjOGQyNjEwOTQyZjY=" -o /root/harness-delegate.tar.gz

  echo "Extracting..."
  tar -zxvf /root/harness-delegate.tar.gz -C /root

  echo "Starting delegate..."
  cd /root/harness-delegate
  nohup ./start.sh > /tmp/delegate.log 2>&1 &
  echo "Delegate start script executed."
EOT


  tags = ["harness-delegate"]
}

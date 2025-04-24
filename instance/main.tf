provider "google" {
  project = "symbolic-pipe-457709-n9"
  region  = "us-east1"
  zone    = "us-east1-b"
}

resource "google_compute_instance" "delegate_vm" {
  name         = "harness-docker-delegate-vm"
  machine_type = "e2-medium"
  zone         = "us-east1-b"
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network       = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    echo "Updating system..."
    apt-get update -y

    echo "Installing Docker..."
    apt-get install -y docker.io

    echo "Enabling Docker service..."
    systemctl enable docker
    systemctl start docker

    echo "Running Harness Docker Delegate..."
    docker run  --cpus=1 --memory=2g \
  -e DELEGATE_NAME=docker-delegate \
  -e NEXT_GEN="true" \
  -e DELEGATE_TYPE="DOCKER" \
  -e ACCOUNT_ID=ucHySz2jQKKWQweZdXyCog \
  -e DELEGATE_TOKEN=NTRhYTY0Mjg3NThkNjBiNjMzNzhjOGQyNjEwOTQyZjY= \
  -e DELEGATE_TAGS="delegate-tag" \
  -e MANAGER_HOST_AND_PORT=https://app.harness.io us-docker.pkg.dev/gar-prod-setup/harness-public/harness/delegate:25.03.85504
  EOT

  tags = ["harness-docker-delegate"]
}

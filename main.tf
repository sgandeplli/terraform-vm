terraform {
  backend "gcs" {
    bucket  = "sekhar1913"  # Replace with your GCS bucket name
    prefix  = "terraform/state"         # Folder inside the bucket
  }
}

provider "google" {
  project = "sekhar-452813"
  region  = "us-east1"
}

resource "google_compute_instance" "test1" {
  name         = "naruto"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-stream-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}

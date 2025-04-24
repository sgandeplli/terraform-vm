

provider "google" {
  project = "symbolic-pipe-457709-n9"
  region  = "us-east1"
  zone= "us-east1-b"
}

resource "google_compute_instance" "test1" {
  name         = "naruto12"
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

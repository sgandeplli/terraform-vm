provider "google" {
    project = "ferrous-upgrade-446608-k0"
    region = "us-central1"
    zone="us-central1-c"
}

resource "google_compute_instance" "test1" {
  name="sivasai"
  machine_type="e2-micro"
  boot_disk{
     initialize_params {
      image = "centos-cloud/centos-stream-9"
      }

  }
  network_interface{
     network="default"
     access_config{

     }
  }
}

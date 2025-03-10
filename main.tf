provider "google" {
    project = "sekhar-452813"
    region = "us-central1"
    zone="us-central1-b"
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

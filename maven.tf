provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.gcp_project}"
  region      = "${var.region}"
}

//Maven Instance
resource "google_compute_address" "mavenip" {
  name   = "mavenip"
  region = "us-east1"
}


resource "google_compute_instance" "maven" {
  name         = "maven-instance"
  machine_type = "n1-standard-1"
  zone         = "us-east1-b"

  tags = ["name", "maven", "http-server"]

  boot_disk {
    initialize_params {
      image = "centos-7-v20180129"
    }
  }

  // Local SSD disk
  #scratch_disk {
  #}

  network_interface {
    network    = "${var.sonarvpc}"
    subnetwork = "${var.sonarsub}"
    access_config {
      // Ephemeral IP
      nat_ip = "${google_compute_address.mavenip.address}"
    }
  }
  metadata = {
    name = "maven"
  }

  metadata_startup_script = "sudo yum update -y; sudo yum install git -y; sudo git clone https://github.com/iamdaaniyaal/maven.git; cd /; cd maven; sudo chmod 777 /maven/*; sudo sh maven.sh"
}

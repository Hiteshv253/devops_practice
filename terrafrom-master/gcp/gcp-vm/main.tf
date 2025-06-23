terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0" # use the latest stable
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_instance" "default" {
  name         = "terraform-demo-vm"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"

    access_config {
      # Ephemeral external IP
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y apache2
    sudo systemctl start apache2
    echo '<!doctype html><h1>Hello from Terraform GCP Instance</h1>' | sudo tee /var/www/html/index.html
  EOT

  tags = ["web"]
}



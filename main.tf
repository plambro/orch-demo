provider "google" {
    region = "us-east4"
    project = "${var.project_name}"
    credentials = "${file("${var.credentials_path}")}"
}

resource "google_compute_instance" "docker" {
    name = "crisp-word-count-demo"
    machine_type = "f1-micro"
    zone = "us-east4-a"

    boot_disk {
      initialize_params {
          image = "ubuntu-1804-lts"
      }
    }

    network_interface {
      network = "default"

      access_config {
        
      }
    }

    metadata = {
        ssh-keys = "root:${file("${var.public_key_path}")}"
    }

    provisioner "remote-exec" {
      connection {
          type = "ssh"
          user = "root"
          host = self.network_interface[0].access_config[0].nat_ip
          private_key = "${file("${var.private_key_path}")}"
          agent = false
      }

      inline = [
          "curl -fsSL https://get.docker.com -o get-docker.sh",
          "sh get-docker.sh",
          "usermod -aG docker `echo $USER`",
          "docker run -d -p 80:8000 plambro/plambro-demo:latest"
      ]
    }
}

resource "google_compute_firewall" "default" {
    name = "demo-firewall"
    network = "default"

    allow {
      protocol = "tcp"
      ports = ["80"]
    }

    source_ranges = ["0.0.0.0/0"]
}

output "ip" {
  value = "${google_compute_instance.docker.network_interface.0.access_config.0.nat_ip}"
}
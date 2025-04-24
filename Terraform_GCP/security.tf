resource "google_compute_firewall" "allow-ssh-gke" {
  name    = "allow-ssh-gke"
  network = "default" # Replace with your network name if different

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] # Allow from any IP address; restrict this for better security

  target_tags = ["ssh-access"] # Use this tag to apply the rule to specific instances
}
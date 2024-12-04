output "google_compute_instance_ip" {
  value = google_compute_instance.default.id
  description = "The IP of the cgi Virtual Machine created"
}
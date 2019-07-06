output "backend_ip" {
  value = scaleway_server.backend.public_ip
}

output "frontend_ip" {
  value = scaleway_server.frontend.public_ip
}

output "mysql_ip" {
  value = scaleway_server.mysql.public_ip
}
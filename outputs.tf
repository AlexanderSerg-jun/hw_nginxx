output "internal_ip_address_nginxsrv" {
  value = yandex_compute_instance.nginxsrv.network_interface.0.ip_address
}
output "external_ip_address_nginxsrv" {
  value = yandex_compute_instance.nginxsrv.network_interface.0.nat_ip_address
}
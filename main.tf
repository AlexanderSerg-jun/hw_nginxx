//describe vm

resource "yandex_compute_instance" "nginxsrv" {
// имя машины 
    name = "websrv"
// количество ядер и количество памяти    
    resources {
      cores = 2
      memory = 2
      
    }
// загрузочный образ
  boot_disk {
    initialize_params {
      image_id = "fd808e721rc1vt7jkd0o"

    }
  }
// сетевой интерфейс  
    network_interface {
    subnet_id = yandex_vpc_subnet.subnet1.id
    nat       = true
  }
  metadata={
    user-data="${file("~/Otus_new/hw_nginxx/cloud-init.yaml")}"
}
connection {
    type        = "ssh"
    user        = "alex"
    agent       = true
    
    host        = yandex_compute_instance.nginxsrv.network_interface.0.nat_ip_address
  }
provisioner "remote-exec" {
    inline = ["echo 'Start'"]

  }
  provisioner "local-exec" {
    command = "ansible-playbook -i '${self.network_interface.0.nat_ip_address},' --private-key ~/.ssh/id_25519 --user alex provision.yml"
  }
}

// сеть
resource "yandex_vpc_network" "network1" {
    name="network1"
}
// подсеть
resource "yandex_vpc_subnet" "subnet1" {
    name = "subnet1"
    zone = var.zone
    network_id = yandex_vpc_network.network1.id
    v4_cidr_blocks = ["172.18.0.0/24"]
  
}
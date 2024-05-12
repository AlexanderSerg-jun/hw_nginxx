# hw_nginxx
Домашнее задание
Создать Terraform скрипт

Цель:
реализовать первый терраформ скрипт.


Описание/Пошаговая инструкция выполнения домашнего задания:
Необходимо:

реализовать терраформ для разворачивания одной виртуалки в yandex-cloud
запровиженить nginx с помощью ansible
# Реализация
Для раелизации данного задания создаем 7 файлов :

- main.tf - основной файл  конфигурации нашей ВМ
- provider.tf - конфигурация провайдера , в нашем случае Yandex Cloud
- outputs.tf  - файл вывода данных ( айпи адреса внутренний и внешний)
- variables.tf - файл переменных
- cloud-init.yaml - файл с указанием какого пользователя надо создать на ВМ
- provision.yml - плейбук ansible
- ansible.cfg - конфигурация ansible
# Развертывание ВМ 
1.Необходимо склонировать репозиторий себе на машину git clone https://github.com/AlexanderSerg-jun/hw_nginxx.git
2.После чего перейти в склонированную папку командой cd и указанием папки с клоном
3.Выполнить команды пошагово :
  - terraform init ( для подключения модулей)
  - terraform plan ( для просмотра конфигурации будущей вм)
  - terraform apply ( для создания вм в облаке)

в файле main.tf содержатся две строчки :
provisioner "remote-exec" {
    inline = ["echo 'Start'"]

  }
  provisioner "local-exec" {
    command = "ansible-playbook -i '${self.network_interface.0.nat_ip_address},' --private-key ~/.ssh/id_25519 --user alex provision.yml"
  }
  что позволяте автоматически применить playbook
  


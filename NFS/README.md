# Домашнее задание
* vagrant up должен поднимать 2 виртуалки: сервер и клиент;
* на сервере должна быть настроена директория для отдачи по NFS;
* на клиенте она должна автоматически монтироваться при старте (fstab или autofs);
* в сетевой директории должна быть папка upload с правами на запись;
* требования для NFS: NFS версии 3.
* Доп. задание выполняется по желанию.

## Решение

Этот Vagrantfile настраивает две виртуальные машины с Ubuntu 22.04 (Jammy Jellyfish) - "server" и "client". Давайте подробно рассмотрим, что происходит в каждом разделе:

1. Общие настройки:
   - Указывается версия Vagrant, которую нужно использовать - "2".
   - Задается базовый образ виртуальной машины - "ubuntu/jammy64".
   - Устанавливается таймаут загрузки виртуальной машины в 10 минут.

2. Определение виртуальной машины "server":
   - Задается имя хоста - "server".
   - Настраивается частная сетевая карта с IP-адресом "192.168.56.10".
   - Настраиваются ресурсы виртуальной машины: 2 ядра CPU и 1 ГБ RAM.
   - Выполняется провижининг - установка и настройка NFS-сервера:
     - Устанавливается пакет "nfs-kernel-server".
     - Создается директория "/srv/nfs/upload" с правами 777.
     - В файл "/etc/exports" добавляется запись, разрешающая доступ к директории "/srv/nfs" с хоста с IP-адресом "192.168.56.11".
     - Перезапускается служба "nfs-kernel-server".

3. Определение виртуальной машины "client":
   - Задается имя хоста - "client".
   - Настраивается частная сетевая карта с IP-адресом "192.168.56.11".
   - Настраиваются ресурсы виртуальной машины: 2 ядра CPU и 1 ГБ RAM.
   - Выполняется провижининг - установка и настройка NFS-клиента:
     - Устанавливается пакет "nfs-common".
     - Создается директория "/mnt/nfs".
     - В файл "/etc/fstab" добавляется запись, монтирующая удаленную директорию "/srv/nfs" с хоста "192.168.56.10" в локальную "/mnt/nfs".
     - Выполняется монтирование файловой системы.

Таким образом, этот Vagrantfile настраивает две виртуальные машины - "server" и "client". На "server" устанавливается и настраивается NFS-сервер, а на "client" - NFS-клиент, который монтирует удаленную директорию "/srv/nfs" в локальную "/mnt/nfs". Это позволяет организовать общую папку между двумя виртуальными машинами.


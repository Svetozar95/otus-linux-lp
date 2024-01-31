# Задачи:

##### Создать свой Box на vagrantup.com с обновленном ядром 
##### * Пересобрать ядро из исходников
##### ** Настроить VirtualBox Shared Folders

--------------------------------

##### Цель:Получить навыки работы с Git, Vagrant, Packer и публикацией готовых образов в Vagrant Cloud.
--------------------------------

## Создать свой Box на vagrantup.com с обновленном ядром

Бокс создан

```
Vagrant.configure("2") do |config|
  config.vm.box = "Svetozar/centos8s"
  config.vm.box_version = "1"
end
```
Проверку можно осуществить через загрузку [Vagrant File](https://github.com/Svetozar95/otus-linux-lp/blob/main/learn1/Vagrantfile)
```
## Создадим тестовую директорию перейдем в неё
mkdir test; cd test;

## Скачаем готовый Vagrant File 
wget https://github.com/Svetozar95/otus-linux-lp/blob/main/learn1/Vagrantfile

## Запустим vagrant
vagrant up

## Зайдем на серовер 
vagrant ssh

*** При сборке был изменен адресс дистрибутива для загрузки на mirror corbina, что бы было быстрее. Оттуда же взята и CHEKSUM'a. Так при запуске - было увиличено число ресурсов для виртуальной машины, внутри которой происходила сборка. 


```

## * Пересобрать ядро из исходников  (данная работа уже выполнялась в рамках [курса 2021 года](https://github.com/Svetozar95/otus-linux/tree/master/month1/Learn1), процесс - не изменился. )


Для сборки ядра из исходников используем следующий способ


```
# обновляем все пакеты в ситеме после установки
sudo yum -y update

# Устанавливаем необходимое по для сборки
sudo yum groupinstall "Development Tools" -y
sudo yum install -y wget git gcc ncurses-devel make gcc bc bison flex elfutils-libelf-devel openssl-devel 

# Скачиваем исходники нужного нам ядра. Распаковываем и переходим в папку исходников
cd /usr/src/
sudo wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.7.tar.gz
sudo tar -xvf linux-6.7.tar.gz
cd /usr/src/linux-6.7/

# Берем настройки текущего ядра системы
sudo cp -v  /boot/config-$(uname -r) /usr/src/linux-6.7/.config

# Собираем конфиг
sudo make oldconfig

# СОбираем образ и моудли. Далее - у станавливаем
sudo make bzImage
sudo make modules
sudo make
sudo make install
sudo make modules_install

# Устанавливаем версию по умолчанию
sed -i 's/.*GRUB_DEFAULT*.*/GRUB_DEFAULT=0/'  /etc/default/grub

# Обновляем Grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

# Удаляем старое ядро(ядра) из системы (Only for demo! Not Production!)
rm -f /boot/*4*

# Перезапускаем систему
sudo  shutdown -r now
```

## ** Настроить VirtualBox Shared Folders



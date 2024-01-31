# Домашнее задание

1) создать свой RPM (можно взять свое приложение, либо собрать к примеру апач с определенными опциями)
2) создать свой репо и разместить там свой RPM
реализовать это все либо в вагранте, либо развернуть у себя через nginx и дать ссылку на репо

##### * Задания со звездочкой
* реализовать дополнительно пакет через docker

--------------------------------

## Выполняем задание

Собирался nginx 1.18 с модулем nginx-module-vts
 

``` 

cat >> /etc/yum.repos.d/otus.repo << EOF
[otus]
name=otus-linux
baseurl=http://rpm.linuxporn.ru/
gpgcheck=0
enabled=1
EOF


[root@cs775102 ~]#  yum list | grep otus
Failed to set locale, defaulting to C
nginx.x86_64                           1:1.18.0-2.el7.ngx      otus

```

После установки собранного nginx проверить модуль можно так:

```
[root@localhost vagrant]# curl -I localhost/vhost_status
HTTP/1.1 200 OK
Server: nginx/1.18.0
Date: Sun, 28 Feb 2021 19:52:56 GMT
Content-Type: text/html
Connection: keep-alive

[root@localhost vagrant]# curl  localhost/vhost_status

## выдаст много много букв

```
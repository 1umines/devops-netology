Домашнее задание к занятию "3.4. Операционные системы, лекция 2"
========================

1. На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:
-------------------------
```
-поместите его в автозагрузку,
-предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
-удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.
```
Установливаем node_exporter по приведенной документации
```
	root@vagrant:~# wget https://github.com/prometheus/node_exporter/releases/download/v1.3.0/node_exporter-1.3.0.linux-amd64.tar.gz
	root@vagrant:~# tar xzf node_exporter-1.3.0.linux-amd64.tar.gz
	root@vagrant:~# sudo mv node_exporter-1.3.0.linux-amd64/node_exporter /usr/local/bin/
```
Создадим каталог, названный согласно systemd.unit(5), чтобы иметь в дальнейшем возможность менять параметры запуска сервиса:

```
root@vagrant:~# sudo mkdir /etc/systemd/system/node_exporter.service.d

```
Создадим простой файл запуска сервиса:
```
root@vagrant:~# sudo nano /etc/systemd/system/node_exporter.service

[Unit]

Description=Prometheus exporter

Documentation=https://github.com/prometheus/node_exporter

[Install]

WantedBy=multi-user.target

[Service]

ExecStart=/usr/local/bin/node_exporter
```
Добавим параметр, позволяющий передавать процессу переменные окружения через специальный файл:
```
EnvironmentFile=-/etc/netdata/netdata.env
```
vagrant@vagrant:~$ sudo systemctl enable node_exporter
vagrant@vagrant:~$ sudo systemctl start node_exporter
vagrant@vagrant:~$ systemctl status node_exporter
vagrant@vagrant:~$ sudo reboot
vagrant@vagrant:~$ systemctl status node_exporter
```

```
● node_exporter.service - Prometheus exporter
     Loaded: loaded (/etc/systemd/system/node_exporter.service; enabled; vendor preset: enabled)
     Active: active (running) since Sat 2021-11-20 20:29:38 UTC; 23h ago
       Docs: https://github.com/prometheus/node_exporter
   Main PID: 612 (node_exporter)
      Tasks: 5 (limit: 1071)
     Memory: 14.0M
     CGroup: /system.slice/node_exporter.service
             └─612 /usr/local/bin/node_exporter
```

2. Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.
-------------------------
```
CPU:
node_cpu_seconds_total{cpu="0",mode="idle"} 142.05
node_cpu_seconds_total{cpu="0",mode="system"} 3.38
node_cpu_seconds_total{cpu="0",mode="user"} 2.45

node_cpu_seconds_total{cpu="1",mode="idle"} 141.76
node_cpu_seconds_total{cpu="1",mode="system"} 3.94
node_cpu_seconds_total{cpu="1",mode="user"} 3.19

Disk:
node_disk_io_time_seconds_total{device="sda"} 15.348
node_disk_read_bytes_total{device="sda"} 4.9510912e+08
node_disk_read_time_seconds_total{device="sda"} 15.274000000000001
node_disk_write_time_seconds_total{device="sda"} 0.737

Memory:
node_memory_MemAvailable_bytes 7.11995392e+08
node_memory_MemFree_bytes 3.35986688e+08

Network:
node_network_receive_bytes_total{device="eth0"} 1.750126e+06
node_network_receive_errs_total{device="eth0"} 0
node_network_transmit_bytes_total{device="eth0"} 32243
node_network_transmit_errs_total{device="eth0"} 0
```

3. Установите в свою виртуальную машину Netdata. 
-------------------------
```
Установка Netdata:
vagrant@vagrant:~$ curl -s https://packagecloud.io/install/repositories/netdata/netdata/script.deb.sh | sudo bash
vagrant@vagrant:~$ sudo apt-get install netdata

Меняем в конфигурационном файле /etc/netdata/netdata.conf в секции [web] значение с localhost на bind to = 0.0.0.0,
vagrant@vagrant:~$ sudo nano /etc/netdata/netdata.conf
```

добавим в Vagrantfile данные по порту:
```
MacBook-lumines:vagrant lumines$ nano Vagrantfile
config.vm.network "forwarded_port", guest: 19999, host: 19999
MacBook-lumines:vagrant lumines$ vagrant reload
```
Ссылка на скин экрана 
```
https://take.ms/kfdDU
```
4. Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?

Судя по выводу dmesg да, причем даже тип ВМ, так как есть соответсвующая строка: 
```
vagrant@vagrant:~$ dmesg |grep virtualiz
[    0.011547] CPU MTRRs all blank - virtualized system.
[    0.222531] Booting paravirtualized kernel on KVM
[    4.191898] systemd[1]: Detected virtualization oracle.
```

5. Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?
```
vagrant@vagrant:~$ sysctl fs.nr_open
fs.nr_open = 1048576
```
Это максимальное число открытых дескрипторов для ядра (системы), для пользователя задать больше этого числа нельзя (если не менять). 
Число задается кратное 1024, в данном случае =1024*1024. 


Максимальное количество открытых файлов для процесса также регулируется builtin ulimit: "мягкий" лимит, максимальное разрешенное количество открытых файлов процессу:
```
vagrant@vagrant:~$ ulimit -Sn
1024
```

"жесткий" лимит, устанавливается администратором. Пользователь имеет право увеличить "мягкий" лимит до значения "жесткого":
```
vagrant@vagrant:~$ ulimit -Hn
1048576
```

6. Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.

Запускаем процесс
```
vagrant@vagrant:~$ unshare --mount-proc --map-root-user --fork --mount --pid sleep 1h
```

В соседней консоли:
```
vagrant@vagrant:~$ ps aux | egrep sleep
vagrant     1676  0.0  0.0   8080   532 pts/0    S+   19:20   0:00 unshare --mount-proc --map-root-user --fork --mount --pid sleep 1h
vagrant     1677  0.0  0.0   8076   592 pts/0    S+   19:20   0:00 sleep 1h
vagrant     1679  0.0  0.0   8900   736 pts/1    S+   19:20   0:00 grep -E --color=auto sleep

vagrant@vagrant:~$ sudo nsenter --target 1485 --pid --mount

root@vagrant:/# ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
vagrant        1  0.0  0.0   8076   528 pts/0    S+   18:30   0:00 sleep 1h
root           2  0.0  0.4   9836  4032 pts/1    S    19:22   0:00 -bash
root          11  0.0  0.3  11492  3420 pts/1    R+   19:22   0:00 ps aux
```

7. Найдите информацию о том, что такое :(){ :|:& };:. Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

```
Из предыдущих лекций ясно что это функция внутри "{}", судя по всему с именем ":" , которая после опредения в строке запускает саму себя.
внутринности через поиск нагуглил, пораждает два фоновых процесса самой себя,
получается этакое бинарное дерево плодящее процессы 

А функционал судя по всему этот:
[ 3099.973235] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-4.scope
[ 3103.171819] cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-11.scope

Судя по всему, система на основании этих файлов в пользовательской зоне ресурсов имеет определенное ограничение на создаваемые ресурси 
и соответсвенно при превышении начинает блокировать создание числа 

Если установить ulimit -u 50 - число процессов будет ограниченно 50 для пользоователя. 
```



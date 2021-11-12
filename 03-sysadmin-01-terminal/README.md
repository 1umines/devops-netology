Домашнее задание к занятию "3.1. Работа в терминале, лекция 1"
========================

1. Установите средство виртуализации Oracle VirtualBox.
-------------------------
```
MacBook-lumines:vagrant lumines$ vboxmanage --version
6.1.28r147628
```
2.Установите средство автоматизации Hashicorp Vagrant.
-------------------------
```
MacBook-lumines:~ lumines$ vagrant -v
Vagrant 2.2.19
```
создадим домашнюю папку
```
mkdir vagrant
```
заходим в нее и выполняем 
```
vagrant init

MacBook-lumines:~ lumines$ cd vagrant/
MacBook-lumines:vagrant lumines$ vagrant init
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.
MacBook-lumines:vagrant lumines$ 
```

3. В вашем основном окружении подготовьте удобный для дальнейшей работы терминал. Можно предложить:
-------------------------
```
iTerm2 в Mac OS X
Build 3.4.12
```

4. С помощью базового файла конфигурации запустите Ubuntu 20.04 в VirtualBox посредством Vagrant:
-------------------------
Меняем содержимоей файла Vagrantfile  
```
nano Vagrantfile 
```
Вписываем 
```
Vagrant.configure("2") do |config|
 	config.vm.box = "bento/ubuntu-20.04"
 end
```

Выполняем vagrant up для запуска VM
```
MacBook-lumines:vagrant lumines$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Checking if box 'bento/ubuntu-20.04' version '202107.28.0' is up to date...
==> default: Clearing any previously set forwarded ports...
==> default: Clearing any previously set network interfaces...
==> default: Preparing network interfaces based on configuration...
    default: Adapter 1: nat
==> default: Forwarding ports...
    default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Booting VM...
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 127.0.0.1:2222
    default: SSH username: vagrant
    default: SSH auth method: private key
    default: Warning: Connection reset. Retrying...
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
==> default: Mounting shared folders...
    default: /vagrant => /Users/lumines/vagrant
==> default: Machine already provisioned. Run `vagrant provision` or use the `--provision`
==> default: flag to force provisioning. Provisioners marked to run always will still run.
```
```
vagrant suspend -выключит виртуальную машину с сохранением ее состояния (т.е., при следующем vagrant up будут запущены все процессы внутри, которые работали на момент вызова suspend)
vagrant halt выключит виртуальную машину штатным образом.
```
5. Ознакомьтесь с графическим интерфейсом VirtualBox, посмотрите как выглядит виртуальная машина, которую создал для вас Vagrant, какие аппаратные ресурсы ей выделены. Какие ресурсы выделены по-умолчанию?
-------------------------
```
1Gb Озу, 2 процессора, 64 Гб Пзу
```

6. Как добавить оперативной памяти или ресурсов процессора виртуальной машине?
-------------------------
```
Прописать в Vagrantfile размер памяти/процессора

config.vm.provider "virtualbox" do |v|
  v.memory = 1024
  v.cpus = 2
end
```
7. vagrant ssh
-------------------------
```
MacBook-lumines:vagrant lumines$ vagrant ssh
Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-80-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu 11 Nov 2021 06:04:08 PM UTC

  System load:  0.0               Processes:             110
  Usage of /:   2.5% of 61.31GB   Users logged in:       0
  Memory usage: 19%               IPv4 address for eth0: 10.0.2.15
```

8. Ознакомиться с разделами man bash, почитать о настройках самого bash:
-------------------------
```
HISTFILESIZE    строка 562 (максимальное число строк в файле истории для сохранения)
HISTSIZE    строка 571 (максимальное число команд)
ignorespace — команды, начинающиеся с пробела, не сохраняются в списке истории.
ignoredups — повторяющиеся команды не сохраняются.
ignoreboth — это сокращение, включая как ignorespace и ignoredups .
```

9. В каких сценариях использования применимы скобки {} и на какой строчке man bash это описано?
-------------------------
```
 {} - RESERVED WORDS Зарезервированные слова - это слова, которые имеют особое значение для оболочки. Они используются для начала и завершения составных команд оболочки       строка 130
```
10. Основываясь на предыдущем вопросе, как создать однократным вызовом touch 100000 файлов? А получилось ли создать 300000? Если нет, то почему?
-------------------------
```
touch {1..100000} 
Создаст файлы 1, 2, 2....100000


Создать 300000 файлов невозможно.
Ошибка - слишком длинный аргумент
```

11. В man bash поищите по /\[\[. Что делает конструкция [[ -d /tmp ]] 
-------------------------
```
Compound Commands      строка 187
[[ -d /tmp ]] проверяет условие наличия каталога каталога /tmp и в зависимости от результата возвращает переменной статус  0 или 1
```
12. Основываясь на знаниях о просмотре текущих (например, PATH) и установке новых переменных; командах, которые мы рассматривали, добейтесь в выводе type -a bash в виртуальной машине наличия первым пунктом в списке:
bash is /tmp/new_path_directory/bash
bash is /usr/local/bin/bash
bash is /bin/bash
-------------------------
```
Есть такая переменная PATH предназначена она для того что бы при обращении к ней различных команд, linux автоматически находил путь до их исполняемого фала. Для данной задачи я создал необходимые директории с помощью mkdir и скопировал в них с помощью cp исполняемый файл bash. C помощью echo $PATH узнал какие директории входят в PATH и добавил недостающие командой export PATH=$PATH: /usr/local и export PATH=$PATH: /tmp/new_path_directory. Теперь при использовании type -a bash мы получаем необходимый вывод указанный выше.
Все изменения с файлом PATH проделанные выше после перезапуска профиля откатятся к дефолтным, для постоянных изменений необходимо в файле профиля ~/.bashrc внести эти самые изменения и сохранить файл. После этих манипуляций изменения будут применяться при каждом входе в профиль.
```

13. Чем отличается планирование команд с помощью batch и at?
-------------------------
```
at — это утилита командной строки, которая позволяет вам планировать выполнение команд в определенное время. Задания, созданные с помощью at , выполняются только один раз.
batch  планирует задания и выполняет их в пакетной очереди, если позволяет уровень загрузки системы. По умолчанию задания выполняются, когда средняя загрузка системы ниже 1,5. Значение нагрузки можно указать при вызове демона atd . Если средняя загрузка системы выше указанной, задания будут ждать в очереди.
```




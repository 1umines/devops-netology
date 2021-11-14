Домашнее задание к занятию "3.2. Работа в терминале, лекция 2"
========================

1. Какого типа команда cd? Попробуйте объяснить, почему она именно такого типа; опишите ход своих мыслей, если считаете что она могла бы быть другого типа.
-------------------------
```
vagrant@vagrant:~$ type cd
cd is a shell builtin
```
cd - команда (change directory — изменить каталог), встроенная в оболочку bash. 

2. Какая альтернатива без pipe команде grep <some_string> <some_file> | wc -l? man grep поможет в ответе на этот вопрос. Ознакомьтесь с документом о других подобных некорректных вариантах использования pipe.
-------------------------
grep(1):
```
-c, --count
Suppress normal output; instead print a count of matching lines for each input file. With the -v, --invert-match option (see below), count non-matching lines.
```

3. Какой процесс с PID 1 является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?
-------------------------
```
vagrant@vagrant:~$ ps 1
    PID TTY      STAT   TIME COMMAND
      1 ?        Ss     0:01 /sbin/init
```
В каждой Unix системе есть один процесс с специальным идентификатором 1. Он запускается ядром перед всеми последующими процессами, и он является также родительским процессом для всех последующих/остальных процессов кто не смог найти себе родителя. Вследствие, он может делать много того чего не могут позволить себе другие процессы. Также он несет ответственность за некоторые вещи за которые не отвечают другие процессы, например, за поднятие и поддержку юзерспейса во время загрузки системы.

Исторически в Linux, программное обеспечение действующее как PID 1 был многоуважаемый пакет sysvinit, думается он слишком долго оставался на этом поприще. Много раз предлагались замены, но только один из них был действительно принят: Upstart, который сейчас нашел свою дорогу в многие из главных дистрибутивов.

Как было упомянуто, главная ответственность системы загрузки поднятие юзерспейса (пользовательского окружения). И хорошая система загрузки должна делать это быстро. К сожалению, традиционная система загрузки SysV в действительности была не быстрой.


UPDATE: Upstart в настоящее время признана устаревшей и для многих дистрибутивов планируется переход на systemd.

4. Как будет выглядеть команда, которая перенаправит вывод stderr ls на другую сессию терминала?
-------------------------
```
 ls xxx 2>/dev/pts/1
```

5. Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.
-------------------------
```
vagrant@vagrant:~$  echo test > test
vagrant@vagrant:~$ cat <./test >test.out
vagrant@vagrant:~$ cat test.out
test

```

7. Выполните команду bash 5>&1. К чему она приведет? Что будет, если вы выполните echo netology > /proc/$$/fd/5? Почему так происходит?
-------------------------
```
vagrant@vagrant:~$ bash 5>&1
vagrant@vagrant:~$ echo netology > /proc/$$/fd/5
netology
vagrant@vagrant:~$ echo $$
13291
vagrant@vagrant:~$ ps
    PID TTY          TIME CMD
   1215 pts/0    00:00:00 bash
  13291 pts/0    00:00:00 bash
  13298 pts/0    00:00:00 ps
```

Команда bash 5>&1 запустит оболочку с перенаправлением потока ввода-вывода с файловым дескриптором 5 в стандартный поток вывода. В переменной $$ хранится PID текущей оболочки, поэтому вторая команда выводит строку "netology" в поток с дескриптором 5 текущей оболочки, который, в свою очередь, перенаправлен в поток стандартного вывода, который связан с текущим терминалом.

8. 
```
https://stackoverflow.com/questions/2342826/how-can-i-pipe-stderr-and-not-stdout

find / -name ls 2>&1 1>/dev/pts/1 | cat > err
```
9. Что выведет команда cat /proc/$$/environ? Как еще можно получить аналогичный по содержанию вывод?
-------------------------
```
Команда cat /proc/$$/environ выведет переменные окружения текущей оболочки. 
Подобный вывод выдаст команда set.
```

10. Используя man, опишите что доступно по адресам /proc/<PID>/cmdline, /proc/<PID>/exe.
-------------------------
```
 /proc/[pid]/cmdline
              This  read-only file holds the complete command line for the process, unless the process is a zombie.  In the latter case, there is nothing in this file: that is,
              a read on this file will return 0 characters.  The command-line arguments appear in this file as a set of strings separated by null bytes ('\0'), with  a  further
              null byte after the last string.

/proc/[pid]/exe
              Under Linux 2.2 and later, this file is a symbolic link containing the actual pathname of the executed command.  This symbolic link can be dereferenced  normally;
              attempting  to open it will open the executable.  You can even type /proc/[pid]/exe to run another copy of the same executable that is being run by process [pid].
              If the pathname has been unlinked, the symbolic link will contain the string '(deleted)' appended to the original pathname.  In a multithreaded process, the  con‐
              tents of this symbolic link are not available if the main thread has already terminated (typically by calling pthread_exit(3)).
```

11. Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью /proc/cpuinfo.
-------------------------
```
vagrant@vagrant:~$ cat /proc/cpuinfo | grep sse
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti fsgsbase avx2 invpcid rdseed clflushopt md_clear flush_l1d
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx rdtscp lm constant_tsc rep_good nopl xtopology nonstop_tsc cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single pti fsgsbase avx2 invpcid rdseed clflushopt md_clear flush_l1d
```

```
sse sse2 ssse3 sse4_1 sse4_2
```
14. sudo echo string > /root/new_file не даст выполнить перенаправление под обычным пользователем, так как перенаправлением занимается процесс shell'а, который запущен без sudo под вашим пользователем. Для решения данной проблемы можно использовать конструкцию echo string | sudo tee /root/new_file. Узнайте что делает команда tee и почему в отличие от sudo echo команда с sudo tee будет работать.
-------------------------
```
Команда sudo меняет эффективный UID непосредственно для процесса-аргумента, то есть для sudo echo string > /root/new_file, а перенаправлением стандартного вывода занимается непосредстенно оболочка, выполняющаяся под неизменным EUID, - поэтому первый вариант команды не будет работать. Команда же tee(1) самостоятельно выводит свой стандартный ввод на свой же стандартный вывод и параллельно в файл, имя которого передано ей в качестве аргумента. Во втором варианте команды echo string | sudo tee /root/new_file sudo изменит EUID программы tee и у той хватит прав записать в домашний каталог пользователя root.
```

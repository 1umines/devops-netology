Домашнее задание к занятию «2.3. Ветвления в Git»
========================

Задание №1 – Ветвление, merge и rebase.
-------------------------

_________________
Создаем каталог урока
```
mkdir 02-git-03-branching
```
Создаем файл с описанием 
```
nano 02-git-03-branching/README.md
```
Создаем каталог задания - branching
```
mkdir 02-git-03-branching/branching
```
Создаем файлы merge.sh и rebase.sh с описанием:
```
nano 02-git-03-branching/branching/merge.sh
nano 02-git-03-branching/branching/rebase.sh

добавим сожержимое: 

#!/bin/bash
# display command line options

count=1
for param in "$*"; do
    echo "\$* Parameter #$count = $param"
    count=$(( $count + 1 ))
done
```

добавим коммит с описанием "prepare for merge and rebase"
```
git add 02-git-03-branching/
git commit -m 'prepare for merge and rebase'
```

Подготовка файла merge.sh.
-------------------------

Создаём ветку git-merge
```
git switch -c git-merge
```

Проверим
```
$ git branch
```

Замените в ней содержимое файла merge.sh на
```
nano 02-git-03-branching/branching/merge.sh
```
```
#!/bin/bash
# display command line options

count=1
for param in "$@"; do
    echo "\$@ Parameter #$count = $param"
    count=$(( $count + 1 ))
done
```

Делаем коммит и отправляем в ветку git-merge
```
git add 02-git-03-branching/
git commit -m 'merge: @ instead *'
MacBook-lumines:devops-netology lumines$ git push -u origin git-merge
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 4 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 425 bytes | 425.00 KiB/s, done.
Total 5 (delta 3), reused 0 (delta 0)
remote: Resolving deltas: 100% (3/3), completed with 3 local objects.
remote:
remote: Create a pull request for 'git-merge' on GitHub by visiting:
remote:      https://github.com/1umines/devops-netology/pull/new/git-merge
remote:
To https://github.com/1umines/devops-netology.git
 * [new branch]      git-merge -> git-merge
Branch 'git-merge' set up to track remote branch 'git-merge' from 'origin'.

```


Ещё изменение в merge.sh:

```
nano 02-git-03-branching/branching/merge.sh
#!/bin/bash
# display command line options

count=1
while [[ -n "$1" ]]; do
    echo "Parameter #$count = $1"
    count=$(( $count + 1 ))
    shift
done

```

Снова делаем коммит и отправляем в ветку git-merge
```
git commit -a -m 'merge: use shift'
git push -u origin git-merge
```

Возвращаемся в ветку main
-------------------------
```
MacBook-lumines:devops-netology lumines$ git switch main
Switched to branch 'main'
```

Меняем в ветке main содержимое файла rebase.sh
```
nano 02-git-03-branching/branching/rebase.sh
#!/bin/bash
# display command line options

count=1
for param in "$@"; do
    echo "\$@ Parameter #$count = $param"
    count=$(( $count + 1 ))
done

echo "====="
```

Отправим изменения ветки main
```
git add 02-git-03-branching/
git commit -m 'edit rebase.sh to main'
git push -u origin main
MacBook-lumines:devops-netology lumines$ git push -u origin main
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 4 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 561 bytes | 561.00 KiB/s, done.
Total 5 (delta 2), reused 0 (delta 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/1umines/devops-netology.git
   96703c7..cced925  main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
```

Подготовка файла rebase.sh.
-------------------------

Находим коммит 'prepare for merge and rebase' что бы узнать его 
```
MacBook-lumines:devops-netology lumines$ git log --grep 'prepare for merge and rebase'
commit 96703c794b8456d7c064d8ef11d08fbf18920646 (gitlab/main, bitbucket/main)
Author: Kravtsov Egor <luminesx@gmail.com>
Date:   Mon Nov 1 18:36:43 2021 +0300

    prepare for merge and rebase
```

Делаем переход на него:
```
MacBook-lumines:devops-netology lumines$ git checkout 96703c794b8456d7c064d8ef11d08fbf18920646
Note: switching to '96703c794b8456d7c064d8ef11d08fbf18920646'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at 96703c7 prepare for merge and rebase
```

Создаём на этом моменте новую ветку git-rebaseX (git-rebase пришлось удалить, что то пошло не так)
```
git switch -c git-rebaseX

MacBook-lumines:devops-netology lumines$ git switch -c git-rebaseX
Switched to a new branch 'git-rebaseX'

MacBook-lumines:devops-netology lumines$ git branch
  fix
  git-merge
* git-rebaseX
  main
```

Изменяем файл rebase.sh 
```
nano 02-git-03-branching/branching/rebase.sh

#!/bin/bash
# display command line options

count=1
for param in "$@"; do
    echo "Parameter: $param"
    count=$(( $count + 1 ))
done

echo "====="
```

Отправим коммит в новую ветку git-rebase
```
git add 02-git-03-branching/
git commit -m 'git-rebase 1.0'

MacBook-lumines:devops-netology lumines$ git push -u origin git-rebaseX
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 4 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 463 bytes | 463.00 KiB/s, done.
Total 5 (delta 3), reused 0 (delta 0)
remote: Resolving deltas: 100% (3/3), completed with 3 local objects.
remote:
remote: Create a pull request for 'git-rebaseX' on GitHub by visiting:
remote:      https://github.com/1umines/devops-netology/pull/new/git-rebaseX
remote:
To https://github.com/1umines/devops-netology.git
 * [new branch]      git-rebaseX -> git-rebaseX
Branch 'git-rebaseX' set up to track remote branch 'git-rebaseX' from 'origin'.
```

Заменив echo "Parameter: $param" на echo "Next parameter: $param"
```
nano 02-git-03-branching/branching/rebase.sh

```

Делаем коммит git-rebase 2 и пушим
```
git add 02-git-03-branching/
git commit -m 'git-rebase 2.0'

MacBook-lumines:devops-netology lumines$ git push -u origin git-rebaseX
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 4 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 434 bytes | 434.00 KiB/s, done.
Total 5 (delta 3), reused 0 (delta 0)
remote: Resolving deltas: 100% (3/3), completed with 3 local objects.
To https://github.com/1umines/devops-netology.git
   79a34ad..129fcdb  git-rebaseX -> git-rebaseX
Branch 'git-rebaseX' set up to track remote branch 'git-rebaseX' from 'origin'.
```

Смотрим промежуточный итог (совпадает со скрином в задании)
```
https://take.ms/u4fM6
```


Merge
-------------------------

Сливаем ветку git-merge в main, для этого возвращаемся в ветку main, делаем слияние и пушим
```
git switch main

git merge git-merge
git push -u origin main
MacBook-lumines:devops-netology lumines$ git push -u origin main
Enumerating objects: 10, done.
Counting objects: 100% (10/10), done.
Delta compression using up to 4 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 432 bytes | 432.00 KiB/s, done.
Total 4 (delta 2), reused 0 (delta 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/1umines/devops-netology.git
   cced925..b77b60e  main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
```

Смотрим изменения:
```
https://take.ms/8la9o
```

Rebase
-------------------------

Перед мержем ветки git-rebase выполним ее rebase на main. 

Переключаемся на ветку git-rebase
```
MacBook-lumines:devops-netology lumines$ git checkout git-rebase
Switched to branch 'git-rebase'
Your branch is up to date with 'origin/git-rebase'.
```

Rebase
Делаем  git rebase -i main
```
test
```



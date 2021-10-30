Задание Основы Git

Создан публичный репозиторий на GitLab
```
https://gitlab.com/1umines/devops-netology
```
Создан публичный репозиторий на bitbucket
```
https://bitbucket.org/1umines/devops-netology/src/master/
```

Командой git remote -v смотрим подклбчюенные репозитории. Подключен только GitHub
```
MacBook-lumines:devops-netology lumines$ git remote -v
origin	https://github.com/1umines/devops-netology.git (fetch)
origin	https://github.com/1umines/devops-netology.git (push)
```
Добавим репозеторий gitlab.com под именем gitlab
```
git remote add gitlab https://gitlab.com/1umines/devops-netology.git
```

Добавим репозеторий bitbucket.org под именем bitbucket
```
git remote add bitbucket https://1umines@bitbucket.org/1umines/devops-netology.git
```
Смотрим вывод команды git remote -v
```
MacBook-lumines:devops-netology lumines$ git remote -v
bitbucket	https://1umines@bitbucket.org/1umines/devops-netology.git (fetch)
bitbucket	https://1umines@bitbucket.org/1umines/devops-netology.git (push)
gitlab	https://gitlab.com/1umines/devops-netology.git (fetch)
gitlab	https://gitlab.com/1umines/devops-netology.git (push)
origin	https://github.com/1umines/devops-netology.git (fetch)
origin	https://github.com/1umines/devops-netology.git (push)
```
Локально добавлены 3 репозетория: GitНub, GitLab, bitbucket

Заливаем локальный репозиторий на gitlab.com и itbucket
```
git push -u origin main
git push -u gitlab main
git push -u bitbucket main
```

Теги
создание легковестного тега
```
git tag v0.0
```

аннотированный тег с комментарием 
```
git tag -a v0.1 -m 'annot tag'
```
проверка 
```
MacBook-lumines:02-git-02-base lumines$ git log  -5
commit 8e28d0e1504f0a5142581d27e1dceb93bb9ec68d (HEAD -> main, tag: v0.2, origin/main, origin/HEAD, gitlab/main, bitbucket/main)
Author: Kravtsov Egor <luminesx@gmail.com>
Date:   Fri Oct 29 20:37:10 2021 +0300

    tag info

commit 4c5e92e9c46992b5433df379510aed6eec94748b (tag: v0.1, tag: v0.0)
Author: Kravtsov Egor <luminesx@gmail.com>
Date:   Fri Oct 29 18:49:25 2021 +0300

    testing
```

Опубликуем теги в репозиториях
```
GitHub:

  $git push origin HEAD:main
  $git push origin --tags HEAD:main
  $git push origin HEAD
```
```
GitLab:

  $git push gitlab HEAD:main
  $git push gitlab --tags HEAD:main
  $git push gitlab HEAD
```
```
Bitbucket

  $git push bitbucket HEAD:main
  $git push bitbucket --tags HEAD:main
  $git push bitbucket HEAD
```

Находим коммит с комментарием "file delete and move"

```
MacBook-lumines:devops-netology lumines$ git log --grep="file delete and move"
commit a52778848917d77f986338bff4e1b4635c44acad
Author: Kravtsov Egor <luminesx@gmail.com>
Date:   Thu Oct 28 11:18:57 2021 +0300

    file delete and move
```

Переходим на этот коммит

```
MacBook-lumines:devops-netology lumines$ git checkout a52778848917d77f986338bff4e1b4635c44acad
Note: switching to 'a52778848917d77f986338bff4e1b4635c44acad'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

  git switch -c <new-branch-name>

Or undo this operation with:

  git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at a527788 file delete and move
```

Делаем переход на ветку fix

```
MacBook-lumines:devops-netology lumines$ git switch -c fix
Switched to a new branch 'fix'
MacBook-lumines:devops-netology lumines$ git push -u origin fix
Total 0 (delta 0), reused 0 (delta 0)
remote:
remote: Create a pull request for 'fix' on GitHub by visiting:
remote:      https://github.com/1umines/devops-netology/pull/new/fix
remote:
To https://github.com/1umines/devops-netology.git
 * [new branch]      fix -> fix
Branch 'fix' set up to track remote branch 'fix' from 'origin'.
```
Делаем коммит в ветке fix

```
MacBook-lumines:devops-netology lumines$ git add .
MacBook-lumines:devops-netology lumines$ git commit -m 'First commit to fix'
[fix 29551b0] First commit to fix
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 .DS_Store
MacBook-lumines:devops-netology lumines$ git push
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 4 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 908 bytes | 908.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To https://github.com/1umines/devops-netology.git
   a527788..29551b0  fix -> fix
```

Смотрим схему после коммита в ветку fix
```
https://github.com/1umines/devops-netology/network
```

Смотрим историю коммитов в ветке fix
```
MacBook-lumines:devops-netology lumines$ git log --oneline -10
29551b0 (HEAD -> fix, origin/fix) First commit to fix
a527788 file delete and move
599023a added terraform folders
88d3495 First commit
43a2d9b Initial commit
```

Правим файл из PyCharm



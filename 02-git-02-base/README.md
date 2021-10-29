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
git show v0.1
MacBook-lumines:devops-netology lumines$ git show v0.1
tag v0.1
Tagger: Kravtsov Egor <luminesx@gmail.com>
Date:   Fri Oct 29 20:32:58 2021 +0300

annot tag

commit 4c5e92e9c46992b5433df379510aed6eec94748b (HEAD -> main, tag: v0.1, tag: v0.0, origin/main, origin/HEAD, gitlab/main)
Author: Kravtsov Egor <luminesx@gmail.com>
Date:   Fri Oct 29 18:49:25 2021 +0300
```

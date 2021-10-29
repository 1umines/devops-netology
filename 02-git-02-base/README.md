Задание Основы Git

Создан публичный репозиторий на GitLab
```
https://gitlab.com/1umines/devops-netology
```
Создан публичный репозиторий на bitbucket
https://bitbucket.org/1umines/devops-netology/src/master/

Командой git remote -v смотрим подклбчюенные репозитории. Подключен только GitHub

MacBook-lumines:devops-netology lumines$ git remote -v
origin	https://github.com/1umines/devops-netology.git (fetch)
origin	https://github.com/1umines/devops-netology.git (push)

Добавим репозеторий gitlab.com под именем gitlab
git remote add gitlab https://gitlab.com/1umines/devops-netology.git

Добавим репозеторий bitbucket.org под именем bitbucket
git remote add bitbucket https://1umines@bitbucket.org/1umines/devops-netology.git

Смотрим вывод команды 
git remote -v

MacBook-lumines:devops-netology lumines$ git remote -v
bitbucket	https://1umines@bitbucket.org/1umines/devops-netology.git (fetch)
bitbucket	https://1umines@bitbucket.org/1umines/devops-netology.git (push)
gitlab	https://gitlab.com/1umines/devops-netology.git (fetch)
gitlab	https://gitlab.com/1umines/devops-netology.git (push)
origin	https://github.com/1umines/devops-netology.git (fetch)
origin	https://github.com/1umines/devops-netology.git (push)

Локально добавлены 3 репозетория: GitНub, GitLab, bitbucket

Заливаем локальный репозиторий на gitlab.com и itbucket
git push -u gitlab 
git push -u bitbucket

Создание каталога для выполнения задания "Системы контроля версий"
$mkdir 02-git-01-vcs

Создание файла с описанием задания
nano  02-git-01-vcs/README.md

Команды для выполнения задания:

Добавление имени
git config --global user.name

Добавление почты
git config --global user.email johndoe@example.com

Создание файла сописанием в каталоге 02-git-01-vcs
git add 02-git-01-vcs/readme.md

Проверка статуса
git status

Первый коммит
git commit -m 'First commit'

Создаю файлик .gitignore в котором бует список игнорируемых файлов для отправки в гит (остаются у меня локально)
touch 02-git-01-vcs/.gitignore

Создание каталога terraform
mkdir 02-git-01-vcs/terraform

Создание и добавление игнорируемых файлв в каталоге terraform согласно заданию
nano 02-git-01-vcs/terraform/.gitignore

Редактирование файла readme в каталоге terraform
nano 02-git-01-vcs/terraform/readme.md

Добавление каталога terraform в следующий коммит
git add 02-git-01-vcs/terraform/

Коммит с комантарием "добавление gitignore"
git commit -m 'Added gitignore'

Создание файла will_be_deleted.txt с добавлением текста will_be_deleted
echo will_be_deleted > 02-git-01-vcs/will_be_deleted.txt

Создание файла will_be_moved.txt с добавлением текста will_be_moved
echo will_be_moved > 02-git-01-vcs/will_be_moved.txt

Добавлние каталога 02-git-01-vcs со всеми вложеними в следующий коммит
git add 02-git-01-vcs/*

Коммит с коментарием 
git commit -m 'file delete and move'

Удаление файла will_be_deleted.txt в каталоге 02-git-01-vcs
git rm 02-git-01-vcs/will_be_deleted.txt

Переименовывание файла will_be_moved.txt в has_been_moved.txt
git mv 02-git-01-vcs/will_be_moved.txt 02-git-01-vcs/has_been_moved.txt

Добавление коммита с коментарием 
git commit -m 'Prepare to delete and move'

Отправка изменений
git push

Будут игнорироваться файлы любые волженные файлы в подкаталог .terraform
**/.terraform/*

Файлы которые заканчиваются на .tfstate и содержащие в названии .tfstate.
*.tfstate
*.tfstate.*

Файл crash.log

Файлы с расширением .tfvars
*.tfvars

Файлы override в разных вариациях
override.tf
override.tf.json
*_override.tf
*_override.tf.json

Конфигурационные файлы
.terraformrc
terraform.rc

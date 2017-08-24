# Déploiement chez Eolas

### Pré requis :
  - machine de type unix (Linux ou MacOS)
  - python 2.7 minimum
  - ansible
  - accès en ssh aux machines cibles
  - une paire de clés SSH par environnement (PREPROD et PROD)

### Variables :
  - `ENV` : environnement cible du playbook. Il peut s'agire de PREPROD ou PROD.
  - `PACKAGE_NAME` : nom du packake applicatif contenant l'application (livré avec le code Ansible).

_Note : dans les instructions de déploiement, les variables sont marqués comme suit `<ENV>`._

_Note 2 : chaque fois qu'une commande précise `--ask-vault-pass` il faut lui indiquer le mot de passe du fichier de variables chiffrées._

### Déploiement :

##### Etape 1 : setup ssh
Dans "inventories/first_setup/&lt;ENV&gt;.ini", remplir les variables "ansible_public_key_file" et "ansible_ssh_private_key_file".

##### Etape 2 : Bootstrap des machines

`ansible-playbook -i inventories/first_setup/<ENV>.ini first_setup.yml`

##### Etape 3 : Installation de postgres en mode redondé

`ansible-playbook -i inventories/<ENV>.ini -t postgresql --ask-vault-pass install.yml`

##### Etape 4 : Installation de redis en mode redondé
`ansible-playbook -i inventories/<ENV>.ini -t redis --ask-vault-pass install.yml`

##### Etape 5 : Installation de ruby
`ansible-playbook -i inventories/<ENV>.ini -t ruby --ask-vault-pass install.yml`

##### Etape 6 : Installation de l'application
`ansible-playbook -i inventories/<ENV>.ini -t webapps --ask-vault-pass -e "package=<PACKAGE_NAME>" install.yml`

##### Etape 7 : installation des reverse proxies et de pgbouncer
`ansible-playbook -i inventories/<ENV>.ini -t --ask-vault-pass load-balancer install.yml`

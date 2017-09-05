# Déploiement chez Eolas

### Pré requis :
  - machine de type unix (Linux ou MacOS)
  - python 2.7 minimum
  - ansible 2.3 minimum
  - accès en ssh aux machines cibles
  - une paire de clés SSH par environnement (PREPROD et PROD)

### Variables :
  - `ENV` : environnement cible du playbook. Il peut s'agire de PREPROD ou PROD.
  - `PACKAGE_NAME` : nom du packake applicatif contenant l'application (livré avec le code Ansible).

_Note : dans les instructions de déploiement, les variables sont marqués comme suit `<ENV>`._

_Note 2 : chaque fois qu'une commande précise `--ask-vault-pass` il faut lui indiquer le mot de passe du fichier de variables chiffrées._

### Déploiement :

##### Etape 1 : setup ssh
Dans `inventories/first_setup/<ENV>.ini` et `inventories/<ENV>.ini`, remplir les variables _"ansible_public_key"_ et _"ansible_ssh_private_key_file"_.

##### Etape 2 : Bootstrap des machines

`ansible-playbook -u root -k -i inventories/first_setup/<ENV>.ini first_setup.yml`

_(Fournir le mode de passe root lors du premier setup.)_

##### Etape 3 : Installation de postgres en mode redondé

`ansible-playbook -i inventories/<ENV>.ini -t postgresql --ask-vault-pass install.yml`

##### Etape 4 : Installation de redis en mode redondé
`ansible-playbook -i inventories/<ENV>.ini -t redis --ask-vault-pass install.yml`

##### Etape 5 : Installation de ruby
`ansible-playbook -i inventories/<ENV>.ini -t ruby --ask-vault-pass install.yml`

##### Etape 6 : Installation de l'antivirus
`ansible-playbook -i inventories/<ENV>.ini -t clamav --ask-vault-pass install.yml`

##### Etape 7 : Installation de l'application
`ansible-playbook -i inventories/<ENV>.ini -t mpal-web --ask-vault-pass -e "package=<PACKAGE_NAME>" install.yml`

##### Etape 8 : installation des reverse proxies et de pgbouncer
`ansible-playbook -i inventories/<ENV>.ini -t --ask-vault-pass load-balancers install.yml`

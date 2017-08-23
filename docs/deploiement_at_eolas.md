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

### Déploiement :
1. Dans "inventories/first_setup/&lt;ENV&gt;.ini", remplir les variables "ansible_public_key_file" et "ansible_ssh_private_key_file".

2. `ansible-playbook -i inventories/first_setup/<ENV>.ini first_setup.yml`

3. `ansible-playbook -i inventories/<ENV>.ini -t postgresql --ask-vault-pass install.yml`
  (renseigner le mot de passe vault)

4. `ansible-playbook -i inventories/<ENV>.ini -t redis --ask-vault-pass install.yml`

5. `ansible-playbook -i inventories/<ENV>.ini -t ruby --ask-vault-pass install.yml`

6. `ansible-playbook -i inventories/<ENV>.ini -t webapps --ask-vault-pass -e "package=<PACKAGE_NAME>" install.yml`

7. `ansible-playbook -i inventories/<ENV>.ini -t --ask-vault-pass load-balancer install.yml`

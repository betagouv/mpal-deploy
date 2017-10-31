# Bascule du PostgreSQL standby en master

### Pré requis :
  - machine de type unix (Linux ou MacOS)
  - python 2.7 minimum
  - ansible 2.3 minimum
  - accès en ssh aux machines cibles
  - une paire de clés SSH par environnement (PREPROD et PROD)

### Variables :
  - `ENV` : environnement cible du playbook. Il peut s'agire de preproduction ou de production.
  - `PACKAGE_NAME` : nom du packake applicatif contenant l'application (livré avec le code Ansible).

_Note : dans les instructions de déploiement, les variables sont marqués comme suit `<ENV>`._

_Note 2 : chaque fois qu'une commande précise `--ask-vault-pass` il faut lui indiquer le mot de passe du fichier de variables chiffrées._

### Bascule :

##### Etape 1 : Changer la configuration dans group_vars/<ENV>/vars.yml :
Mettre à jour les variables `postgresql_master_ip` et `postgresql_slave_ip`

##### Etape 2 : Reconfigurer PGBouncer:
`ansible-playbook -i inventories/<ENV>.ini -t pgbouncer --ask-vault-pass install.yml `

##### Etape 3 : Passer le PostgreSQL standby en master :
  - se connecter sur la machine
  - passer sur le user `postgres`
  - promouvoir le standby avec `repmgr -f /etc/repmgr/repmgr.conf standby promote`
  - vérifier la promotion avec `repmgr -f /etc/repmgr/repmgr.conf cluster show`

##### Etape 4 : Redémarrer les serveurs applicatifs
`ansible-playbook -i inventories/<ENV>.ini -l webapps -t deploy(à changer) --ask-vault-pass install.yml`

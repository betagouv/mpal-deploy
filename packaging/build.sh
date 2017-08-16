#!/bin/bash
set -o nounset
set -o errexit

COMMIT_ID=$1
DATE=`date +%Y-%m-%d_%H-%M-%s`

echo -e "#################################################"
echo -e "Building MPAL with commit id ${COMMIT_ID}"
echo -e "#################################################"

git clone https://github.com/sgmap/mpal.git ~/mpal-webapp
cd mpal-webapp
git checkout ${COMMIT_ID}

echo -e "\n"
echo -e "#################################################"
echo -e "Packaging..."
echo -e "#################################################"
rm -rf vendor
bundle install --deployment
bundle package

echo -e "\n"
echo -e "#################################################"
echo -e "Creating the archive"
echo -e "#################################################"
echo -e "\n"
ID_PACKAGE="${DATE}_${COMMIT_ID}"
cd /home/mpal
tar jcvf /artifact/anah_${ID_PACKAGE}.tar.bz2 mpal-webapp --exclude=.git

echo -e "\n\n"
echo -e "DONE !"
echo -e "Package name : anah_${ID_PACKAGE}.tar.bz2"

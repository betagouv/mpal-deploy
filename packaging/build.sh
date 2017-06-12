#!bin/bash
set -o nounset
set -o errexit

COMMIT_ID=$1
DATE=`date +%Y-%m-%d_%H-%M-%s`

echo -e "#################################################"
echo -e "Building MPAL with commit id ${COMMIT_ID}"
echo -e "#################################################"

git clone https://github.com/sgmap/mpal.git
cd mpal
git checkout ${COMMIT_ID}

echo -e "\n"
echo -e "#################################################"
echo -e "Vendoring..."
echo -e "#################################################"
rm -rf /mpal/vendor
bundle install --path /mpal/vendor/bundle

echo -e "\n"
echo -e "#################################################"
echo -e "Creating the archive"
echo -e "#################################################"
echo -e "\n"
tar jcvf /artifact/anah_${COMMIT_ID}_${DATE}.tar.bz2 /mpal --exclude=.git

echo -e "\n\n"
echo -e "DONE !"
echo -e "Package name : anah_${COMMIT_ID}_${DATE}.tar.bz2"

#!/bin/bash
set -e

function molecule_destroy() {
  (cd $(pwd)/roles/$1 && molecule destroy)
}

directories=$(find . -name 'molecule.yml' | cut -d'/' -f3)
for dir in $directories
do
  echo "#####################################################"
  echo "### Running tests for $dir"
  molecule_destroy $dir
  (cd $(pwd)/roles/$dir && molecule test)
  molecule_destroy $dir
  echo -e "\n"
done

#!/bin/bash
set -e
rootdir=$(pwd)

JEKYLL_ENV=production bundle exec jekyll build

tar czf - _site | ssh ubuntu@building30.com "tar xzf -"
ssh ubuntu@building30.com "sudo rm -rf /var/www/sadiqawosanmi.com && sudo mv _site /var/www/sadiqawosanmi.com"

rm -rf _site
exit

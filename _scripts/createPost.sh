#!/bin/bash
# This script generates a new post or draft

read -p "what is the title of the post? " post_name
read -p "do you want this posted now or later? " post_type

mtype=""
if [ "$post_type" == "now" ] ; then
    mtype="/_posts/"
elif [ "$post_type" == "later" ] ; then
    mtype="/_drafts/"
else
    echo "no ya fool! that is not a valid input. select 1 for now, or 2 for later"
    exit 1
fi

git_root=$(git rev-parse --show-toplevel)
post_path=${git_root}${mtype}$(date +%F)-${post_name// /-}.md

echo "creating post in ${post_path}"
touch "${post_path}"

formated_name=$(echo ${post_name} | sed -e "s/\b\(.\)/\u\1/g")

echo "---" >> "${post_path}"
echo "layout: post" >> "${post_path}"
echo "title: "${formated_name}"" >> "${post_path}"
echo "date: $(date --utc +%FT%T.%3NZ)" >> "${post_path}"
echo "---" >> "${post_path}"

echo "First paragraph goes here and will be used as the excerpt.<!--more--> Everything after the excerpt" >> "${post_path}"

#!/bin/bash

if [ ! $# -ge 1 ];then echo "Enter at least one file";exit 1;fi

for i in $@;
	do if [ ! -f ~/code/paradise/$i ];then echo "$i is not a file";exit 1;fi
done

cd ~/git/creilly/paradise
git checkout master
git pull
git checkout -b newBranch
for i in $@;
	do cp ~/code/paradise/$i ~/git/creilly/paradise/$i
done
git diff *
git add .
read -p "Enter commit message: " MESSAGE
while [ -z "$MESSAGE" ]
	do read -p "Enter a non empty commit message: " MESSAGE
done
git commit -m "$MESSAGE"
git push -u origin newBranch
read -p "Has the request been merged? Enter Y to proceed: " MERGED
while [[ -z "$MERGED" || ! "$MERGED" == "Y" ]]
	do read -p "Has the request been merged? Enter Y to proceed: " MERGED
done
git checkout master
git pull
git push origin --delete newBranch
git branch -d newBranch
echo "Finished"

#!/bin/bash
set -e

while getopts "t" opt;do
	case $opt in
		t) TEST=true ;;
	esac
done
shift $((OPTIND-1))

if [ ! $# -ge 1 ];then echo "Enter at least one file";exit 1;fi

for i in $@;
	do if [ ! -f ~/code/paradise/$i ];then echo "$i is not a file";exit 1;fi
done

if [ ! -z $TEST ];then
	echo "Running unit tests"
	$PHOME/tests.sh | cut -c 40-
	if [ ${PIPESTATUS[0]} -eq 1 ];then
		echo "Unit tests failed, aborting commit"
		exit 1
	fi
fi

echo "Starting commit"
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
while [[ -z "$MERGED" || ! "$MERGED" == [Yy] ]]
	do read -p "Has the request been merged? Enter Y to proceed: " MERGED
done
git checkout master
git pull
git push origin --delete newBranch
git branch -d newBranch
echo "Finished"

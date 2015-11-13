#!/bin/sh

mkdir i-rebase
cd i-rebase
git init

touch FileA
git add FileA
for i in 0 1 2 3; do
	echo "change $i" >> FileA
	git commit -m "\"change $i"\" FileA
	if [ $i -eq 1 ]; then git tag commit0; fi
	if [ $i -eq 2 ]; then git tag commit1; fi
done

git checkout -b BR_ONE commit0 

touch FileB
git add FileB
for i in 0 1 2 ; do
	echo "Big Change $i" >> FileB
	git commit -m "\"BR_ONE change $i"\" FileB
done

git checkout master

for i in 4 5 6 ; do
	echo "change $i" >> FileA
	git commit -m "\"more change change $i"\" FileA
done

git checkout -b BR_TWO commit1

touch FileC
git add FileC
for i in 0 1 2 3 4 5 ; do
	echo "Big Change $i" >> FileC
	git commit -m "\"BR_TWO change $i"\" FileC
done
echo "change 5" >> FileA
git commit -m "\"BR_TWO changes to FileA"\" FileA

git checkout master

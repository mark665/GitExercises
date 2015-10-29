#!/bin/sh

mkdir i-merge
cd i-merge
git init

touch FileA
git add FileA
for i in 0 1 ; do
	echo "change $i" >> FileA
	git commit -m "\"change $i"\" FileA
	if [ $i -eq 0 ]; then git tag commit0; fi
	if [ $i -eq 0 ]; then git tag commit1; fi
done

git checkout -b topic commit0 
touch topic-file
git add topic-file
for i in 0; do
	echo "topic change $i" >> topic-file
	git commit -m "\"topic change $i"\" topic-file
done

git checkout -b fix commit0 
touch fix
git add fix
for i in 0; do
	echo "change $i" >> fix
	git commit -m "\"fix change change $i"\" fix
done

git checkout -b fix-1 commit1

touch fix-1 
git add fix-1
for i in 0; do
	echo "fix-1 change $i" >> fix-1
	git commit -m "\"fix 1  change $i"\" fix-1
done

git checkout master

git merge -m "Merge fix" fix

git merge -m "Merge fix-1" fix-1

git merge -m "Topic" topic


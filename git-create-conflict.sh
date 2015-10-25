#!/bin/sh

mkdir i-merge-conflict
cd i-merge-conflict
git init

touch FileA
git add FileA
for i in 0 1 ; do
	echo "change $i" >> FileA
	git commit -m "\"change $i"\" FileA
	git commit -m "\"change $i"\" FileB
	if [ $i -eq 0 ]; then git tag commit0; fi
	if [ $i -eq 0 ]; then git tag commit1; fi
done

git checkout -b update
touch FileC
git add FileC
for i in 0; do
	echo "topic change $i" >> FileC
	git commit -m "\"topic change $i"\" FileC
done

git checkout -b topic commit0
for i in 0; do
	echo "topic change $i" >> FileA
	git commit -m "\"topic change $i"\" FileA
done

git checkout -b fix commit0 
for i in 0; do
	echo "fix change $i" >> FileA 
	git commit -m "\"fix change change $i"\" FileA
done

git checkout master


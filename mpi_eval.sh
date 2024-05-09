#!/bin/zsh

mpirun bin/print_assign_hosts

aryizes=(6250 12500 25000 50000 100000 200000 400000 800000)

iterC=10
echo "\"NumData\",\"$1\""
for arysize in $aryizes
do
	sum=0
	for i in $(seq $iterC) 
	do
		a=$(mpirun $1 $arysize)
		sum=$((a+sum))
	done
	sum=$((sum/iterC))
	echo "\"$arysize\",\"$sum\""
done

#!/bin/zsh

aryizes=(50000 100000 150000 200000 250000)

iterC=10


for arysize in $aryizes
do
	sum=0
	for i in $(seq $iterC) 
	do
		a=$(mpirun -np 2 bin/p2p_time $arysize)
		sum=$((a+sum))
	done
	sum=$((sum/iterC))
	echo $sum
done

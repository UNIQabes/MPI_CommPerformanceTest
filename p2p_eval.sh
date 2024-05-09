#!/bin/zsh

aryizes=(50000 100000 150000 200000 250000)

iterC=10

echo "\"NumData\",\"P2P\""
for arysize in $aryizes
do
	sum_p2p=0
	for i in $(seq $iterC) 
	do
		a=$(mpirun -np 2 bin/p2p_time $arysize)
		sum_p2p=$((a+sum_p2p))
	done
	sum_p2p=$((sum_p2p/iterC))
	echo "\"$arysize\",\"$sum_p2p\""
done

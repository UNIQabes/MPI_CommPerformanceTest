#!/bin/zsh

aryizes=(50000 100000 150000 200000 250000)

iterC=10

echo "\"ThreadN\",\"P2P\", \"AllGather\""
for arysize in $aryizes
do
	sum_p2p=0
	sum_allgather=0
	for i in $(seq $iterC) 
	do
		a=$(mpirun -np 2 bin/p2p_time $arysize)
		sum_p2p=$((a+sum_p2p))

		a=$(mpirun -np 8 bin/allgather_time $arysize)
		sum_allgather=$((a+sum_allgather))
	done
	sum_p2p=$((sum_p2p/iterC))
	sum_allgather=$((sum_allgather/iterC))
	echo "\"$arysize\",\"$sum_p2p\", \"$sum_allgather\""
done

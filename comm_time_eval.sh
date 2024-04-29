#!/bin/zsh

aryizes=(50000 100000 150000 200000 250000)

iterC=10

echo "\"NumProcess\",\"P2P\", \"AllGather\", \"P2PCircle\""
for arysize in $aryizes
do
	sum_p2p=0
	sum_allgather=0
	sum_p2pcircle=0
	for i in $(seq $iterC) 
	do
		a=$(mpirun -np 2 bin/p2p_time $arysize)
		sum_p2p=$((a+sum_p2p))

		a=$(mpirun -np 8 bin/allgather_time $arysize)
		sum_allgather=$((a+sum_allgather))

		a=$(mpirun -np 8 bin/p2pcircle_time $arysize)
		sum_p2pcircle=$((a+sum_p2pcircle))
	done
	sum_p2p=$((sum_p2p/iterC))
	sum_allgather=$((sum_allgather/iterC))
	sum_p2pcircle=$((sum_p2pcircle/iterC))
	echo "\"$arysize\",\"$sum_p2p\", \"$sum_allgather\",\"$sum_p2pcircle\""
done

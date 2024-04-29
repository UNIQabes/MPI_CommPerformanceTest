bin/p2p_time:p2p_time.c second.c
	mpicc p2p_time.c -o bin/p2p_time

bin/allgather_time:allgather_time.c second.c
	mpicc allgather_time.c -o bin/allgather_time


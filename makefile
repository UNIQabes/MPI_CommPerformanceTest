bin/p2p_time:p2p_time.c second.c
	mpicc p2p_time.c -o bin/p2p_time

bin/allgather_time:allgather_time.c second.c
	mpicc allgather_time.c -o bin/allgather_time

bin/p2pcircle_time:p2pcircle_time.c second.c
	mpicc p2pcircle_time.c -o bin/p2pcircle_time

bin/print_assign_hosts:print_assign_hosts.c
	mpicc print_assign_hosts.c -o bin/print_assign_hosts
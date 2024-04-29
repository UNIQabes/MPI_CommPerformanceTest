#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include "second.c"

int main(int argc, char *argv[])
{
	MPI_Init(&argc, &argv);

	int rank;
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);
	int size;
	MPI_Comm_size(MPI_COMM_WORLD, &size);

	int DataNum = 0;
	if (argc == 2)
	{
		DataNum = atoi(argv[1]);
	}
	else
	{
		fprintf(stderr, "引数が1つではありません\n");
	}

	int localDataNum = (DataNum + size - 1) / size;

	int *buf = malloc(sizeof(int) * DataNum);

	// 計測開始--------------------------------------
	MPI_Barrier(MPI_COMM_WORLD);
	double start = second();

	int to_rank = (rank + 1) % size;
	int from_rank = (size + rank - 1) % size;

	MPI_Status status;
	MPI_Request request;
	// DataNum=1005以上でeager通信からrendezvous通信に切り替わってしまったのでISend関数を使う必要アリ
	// MPI_Send(buf, DataNum, MPI_INT, to_rank, 2024, MPI_COMM_WORLD);
	MPI_Isend(buf, DataNum, MPI_INT, to_rank, 2024, MPI_COMM_WORLD, &request);
	MPI_Recv(buf, DataNum, MPI_INT, from_rank, 2024, MPI_COMM_WORLD, &status);
	MPI_Wait(&request, &status);

	// 計測終了--------------------------------------
	MPI_Barrier(MPI_COMM_WORLD);
	double end = second();

	double commTime = end - start;
	double maxCommTime;

	MPI_Reduce(&commTime, &maxCommTime, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);

	if (rank == 0)
	{
		printf("%lf\n", maxCommTime);
	}

	MPI_Finalize();
}
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

	int *buf = malloc(sizeof(int) * localDataNum * size);

	int *localBuf = malloc(sizeof(int) * DataNum);

	// 計測開始--------------------------------------
	MPI_Barrier(MPI_COMM_WORLD);
	double start = second();

	MPI_Status status;
	MPI_Allgather(localBuf, localDataNum, MPI_INT, buf, localDataNum, MPI_INT, MPI_COMM_WORLD);

	// 計測終了--------------------------------------
	MPI_Barrier(MPI_COMM_WORLD);
	double end = second();

	double commTime = end - start;
	double maxTime = 0;
	MPI_Reduce(&commTime, &maxTime, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);
	if (rank == 0)
	{
		printf("%lf", maxTime);
	}

	MPI_Finalize();
}
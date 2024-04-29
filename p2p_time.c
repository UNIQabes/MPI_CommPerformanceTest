#include <mpi.h>
#include <stdio.h>
#include "second.c"

const int DATANUM = 10000;

int main(int argc, char *argv[])
{
	int buf[DATANUM];
	MPI_Status status;
	int rank;

	MPI_Init(&argc, &argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &rank);

	MPI_Barrier(MPI_COMM_WORLD);
	double start = second();

	if (rank == 0)
	{
		MPI_Send(buf, DATANUM, MPI_INT, 1, 2024, MPI_COMM_WORLD);
	}
	else if (rank == 1)
	{
		MPI_Recv(buf, DATANUM, MPI_INT, 0, 2024, MPI_COMM_WORLD, &status);
	}

	MPI_Barrier(MPI_COMM_WORLD);
	double end = second();

	double commTime = end - start;

	if (rank == 0)
	{
		MPI_Send(&commTime, 1, MPI_INT, 1, 2025, MPI_COMM_WORLD);
	}
	else if (rank == 1)
	{
		double otherCommTime;
		MPI_Recv(&otherCommTime, 1, MPI_INT, 0, 2025, MPI_COMM_WORLD, &status);
		double maxTime = otherCommTime > commTime ? otherCommTime : commTime;
		printf("%lf\n", maxTime);
	}

	MPI_Finalize();
}
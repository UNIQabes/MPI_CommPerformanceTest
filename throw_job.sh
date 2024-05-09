#!/bin/zsh

#sbatch -p bdw2-mixed -N 1 -n 2 --ntasks-per-core=2 -o ./report/out%J_p2p_samecpu -e ./report/err%J_p2p_samecpu mpi_eval.sh bin/p2p_time
#sbatch -p bdw2-mixed -N 1 -n 2 --ntasks-per-core=1 -o ./report/out%J_p2p_samenode -e ./report/err%J_p2p_samenode mpi_eval.sh bin/p2p_time
#sbatch -p bdw2-mixed -N 2 -n 2 --ntasks-per-core=1 -o ./report/out%J_p2p_othernode -e ./report/err%J_p2p_othernode mpi_eval.sh bin/p2p_time
#sbatch -p bdw2-mixed -N 1 -n 8 --ntasks-per-core=1 -o ./report/out%J_collective_1node -e ./report/err%J_collective_1node mpi_eval.sh bin/allgather_time
#sbatch -p bdw2-mixed -N 2 -n 8 --ntasks-per-core=1 -o ./report/out%J_collective_2node -e ./report/err%J_collective_2node mpi_eval.sh bin/allgather_time
#sbatch -p bdw2-mixed -N 3 -n 9 --ntasks-per-core=1 -o ./report/out%J_collective_3node -e ./report/err%J_collective_3node mpi_eval.sh bin/allgather_time
#sbatch -p bdw2-mixed -N 1 -n 8 --ntasks-per-core=1 -o ./report/out%J_p2p_circle_1node -e ./report/err%J_circle_1node mpi_eval.sh bin/p2pcircle_time
#sbatch -p bdw2-mixed -N 2 -n 8 --ntasks-per-core=1 -o ./report/out%J_p2p_circle_2node -e ./report/err%J_circle_2node mpi_eval.sh bin/p2pcircle_time
sbatch -p bdw2-mixed -N 3 -n 9 --ntasks-per-core=1 -o ./report/out%J_p2p_circle_3node -e ./report/err%J_circle_3node mpi_eval.sh bin/p2pcircle_time


# This is a makefile for local execution and profiling...
# TODO: revert makefile to makefile.remote when compiling on the UCT HPCC.
# gprof only used for sequential program - poorly suited to parallel counterpart

particle: particle.c
	 gcc -I -L -pg particle.c -o particle

particle_omp: particle.c
	gcc -I -L particle.c -fopenmp -o particle_omp

run: particle
	./particle 2000 100 100 10 5
	gprof particle.exe gmon.out > prof_output.out # remove .exe when compiling on linux
	cat solution.txt
	python3 plot_solution.py solution.txt

run_omp: particle_omp
	./particle_omp 2000 100 100 10 5
	cat solution.txt
	python3 plot_solution.py solution.txt

clean:
	rm *.exe solution.txt *.out
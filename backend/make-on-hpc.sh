#!/bin/sh
#PBS -N unipept-backend
#PBS -l nodes=1:ppn=24
#PBS -l walltime=72:00:00
#PBS -l vmem=480gb

# Running:
# $ module swap cluster/phanpy
# $ qsub make-on-hpc.sh

# Loading the required modules
module load Java
module load Maven

# Check the current directory
pushd "$PBS_O_WORKDIR"

# Running the makefile
make --debug=v

# Reset the directory
popd


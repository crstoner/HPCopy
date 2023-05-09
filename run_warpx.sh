#!/bin/bash
## Required PBS Directives ----------------
#PBS -l select=1:ncpus=128:mpiprocs=128
#PBS -l walltime=00:30:00
#PBS -q debug
#PBS -A DTRAA02280EA9
#
## Optional PBS Directives -----------------
#PBS -N WarpXCRSJSmithDupe
#PBS -V
#PBS -j oe
#PBS -m be
#PBS -M crstoner1@gmail.com
#
## Execution Block -------------------------
cd $PBS_O_WORKDIR
mkdir wpxrun
cd wpxrun
aprun -n 128 ../main2d.cray.x86-rome.TPROF.MTMPI.ex ../inputs_2d_crsSendit > ./warpx.out
cd ./diags										#To diags dir
ls -1 diag1*/Header | tee movie.visit 			#Create movie.visit
cd ../ 											#Back to wpxrun
cp warpx_used_inputs diags						#Copy inputs to diags for reference
cp warpx_used_inputs diags/reducedfiles			#Copy inputs to reduced files dir for reference
cd diags										#To diags
mv reducedfiles reducedfiles_$(date +%d%b%H%M%Z)#Rename RedDiags for reference on other machines
cd ../..										#Back to workdir
mv wpxrun wpxrun_$(date +%d%b%H%M%Z)			#Rename wpxrun dir for reference


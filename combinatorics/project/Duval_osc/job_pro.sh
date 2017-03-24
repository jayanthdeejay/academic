#PBS -N project
#PBS -l nodes=1:ppn=1
#PBS -l walltime=20:00:00
#PBS -j oe
#PBS -l mem=20gb
#PBS -m abe
cd $PBS_O_WORKDIR
module load python/2.7.1
python project.py 

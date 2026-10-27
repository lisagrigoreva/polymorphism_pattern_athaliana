#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=20G
#SBATCH --array=1-66
#SBATCH --partition=m
#SBATCH --qos="medium"
#SBATCH --time=30:00:00
#SBATCH --output=/groups/nordborg/projects/genome_organization/slurm/ldhat_%A_%a.out
#SBATCH --error=/groups/nordborg/projects/genome_organization/slurm/ldhat_%A_%a.err

#ml build-env/.f2021
#ml samtools/0.1.19-foss-2018b
#ml samtools/1.12-gcc-10.2.0
#ml bwa/0.7.17-foss-2018b
#ml bwa/0.7.17-gcc-10.2.0
# DATA #
export numberofline=$SLURM_ARRAY_TASK_ID
DATAdir=/groups/nordborg/projects/genome_organization/03_processing/009_rho_estimation
export list_samples=${DATAdir}/chr1/vcf_files.txt
export sample=`sed -n $numberofline,"$numberofline"p $list_samples | awk '{print $1}'`

cd /groups/nordborg/projects/genome_organization/03_processing/009_rho_estimation/
# Run LDhat
./LDhat/interval -seq ${DATAdir}/chr1/${sample}.vcf.ldhat.sites -loc ${DATAdir}/chr1/${sample}.vcf.ldhat.locs  -lk 54lk.txt  -its 60000000 -bpen 5 -samp 40000  -prefix ./chr1/${sample}.  
#./LDhat/stat ${sample}rates.txt -seq ${DATAdir}/chunks_chr1/${sample}.vcf.header.vcf.ldhat.sites -loc ${DATAdir}/chunks_chr1/${sample}.vcf.header.vcf.ldhat.locs -prefix ${sample}

#./LDhat/interval  -seq ./chunks_chr1/${sample}.vcf.header.vcf.ldhat.sites  -loc ./chunks_chr1/${sample}.vcf.header.vcf.ldhat.locs   -lk 54lk.txt  -its 60000000 -bpen 1 -samp 4000 -prefix ${sample}

#Create LDhat output (rates)
#./LDhat/stat -input ${sample}rates.txt  -loc  ./chunks_chr1/${sample}.vcf.header.vcf.ldhat.locs -prefix ${sample}

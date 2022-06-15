#!/bin/bash

cd /home/mamakf/alignments/

for filename in *.bam;
do

   echo $filename
   date
   
   bcftools mpileup --threads 24 -f /home/mamakf/GRCh38/GRCh38.primary_assembly.genome.fa $filename | bcftools call --threads 24 -mv -Oz -o /home/mamakf/output/$filename.vcf.gz
   
   tabix /home/mamakf/output/$filename.vcf.gz

done

#!/bin/bash

nextflow run nf-core/sarek -profile docker -r 2.7.1 --step annotate --input "/home/mamakf/ProstatCa/output_f2/VariantCalling/*/{HaplotypeCaller,Strelka}/*.vcf.gz" --outdir /home/mamakf/ProstatCa/output_f3/ --tools VEP,snpEff --target_bed /home/mamakf/ProstatCa/SeqCapEZ_Exome_v3.0_Design_Annotation_files/SeqCap_EZ_Exome_v3_hg19_capture_targets_edited.bed --save_bam_mapped --genome GRCh37 --email fatih.mamak@msfr.ibg.edu.tr --max_memory 120.GB

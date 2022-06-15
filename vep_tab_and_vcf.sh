#!/bin/bash
for filename in *.vcf;
do
   echo $filename
   onlyname="${filename%.vcf*}" 
   echo "Gene_Filtered_$onlyname.tab"
   
   docker run -t -i -v /home/emerald/vep_data:/opt/vep/.vep ensemblorg/ensembl-vep ./vep --cache --af --af_gnomad --tab --symbol --offline --format vcf --force_overwrite --fork 4 --assembly GRCh38 --dir_cache /opt/vep/.vep/ --dir_plugins /opt/vep/.vep/Plugins/ --input_file /opt/vep/.vep/input/$filename --output_file /opt/vep/.vep/output/VEP_$onlyname.tab --plugin dbNSFP,/opt/vep/.vep/Plugins/dbNSFP4.1a_grch38.gz,genename,Ensembl_geneid,Ensembl_transcriptid,HGVSc_ANNOVAR,SIFT_score,Polyphen2_HDIV_score --plugin gnomADc,/opt/vep/.vep/Plugins/gnomADc.gz --custom /opt/vep/.vep/Plugins/clinvar_38.vcf.gz,ClinVar,vcf,exact,0,CLNSIG,CLNREVSTAT,CLNDN --plugin Mastermind,/opt/vep/.vep/Plugins/mastermind_cited_variants_reference-2021.04.02-grch38.vcf.gz   
   
   docker run -t -i -v /home/emerald/vep_data:/opt/vep/.vep ensemblorg/ensembl-vep ./filter_vep --format tab -i /opt/vep/.vep/output/VEP_$onlyname.tab -o /opt/vep/.vep/output/Gene_Filtered_$onlyname.tab --filter "(SYMBOL in /opt/vep/.vep/output/gene_list.txt) and (gnomAD_AF < 0.05 or not gnomAD_AF) and ((IMPACT is HIGH) or (IMPACT is MODERATE))" --force_overwrite
   
   echo $filename
   onlyname="${filename%.vcf*}" 
   echo "Gene_Filtered_$onlyname.vcf"
   
   docker run -t -i -v /home/emerald/vep_data:/opt/vep/.vep ensemblorg/ensembl-vep ./vep --cache --af --af_gnomad --vcf --offline --format vcf --force_overwrite --fork 4 --assembly GRCh38 --dir_cache /opt/vep/.vep/ --dir_plugins /opt/vep/.vep/Plugins/ --input_file /opt/vep/.vep/input/$filename --output_file /opt/vep/.vep/output/VEP_$onlyname.vcf --plugin dbNSFP,/opt/vep/.vep/Plugins/dbNSFP4.1a_grch38.gz,genename,Ensembl_geneid,Ensembl_transcriptid,HGVSc_ANNOVAR,SIFT_score,Polyphen2_HDIV_score --plugin gnomADc,/opt/vep/.vep/Plugins/gnomADc.gz --custom /opt/vep/.vep/Plugins/clinvar_38.vcf.gz,ClinVar,vcf,exact,0,CLNSIG,CLNREVSTAT,CLNDN --plugin Mastermind,/opt/vep/.vep/Plugins/mastermind_cited_variants_reference-2021.04.02-grch38.vcf.gz
   
   docker run -t -i -v /home/emerald/vep_data:/opt/vep/.vep ensemblorg/ensembl-vep ./filter_vep --format vcf -i /opt/vep/.vep/output/VEP_$onlyname.vcf -o /opt/vep/.vep/output/Gene_Filtered_$onlyname.vcf --filter "(SYMBOL in /opt/vep/.vep/output/gene_list.txt) and (gnomAD_AF < 0.05 or not gnomAD_AF) and ((IMPACT is HIGH) or (IMPACT is MODERATE))" --force_overwrite
done


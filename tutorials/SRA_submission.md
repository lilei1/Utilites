# Objective: This is for submitting the raw reads to the NCBI SRA:


### Step1: Submit the [bioProject](https://submit.ncbi.nlm.nih.gov/subs/bioproject/)
Follow the link and start a new BioProject. Fill out the required blanks and submitted. Once you get submitted and processed by NCBI, you are supposed to get the bioProject number, like PRJNA523236.

### Step2: Submit the [biosample](https://submit.ncbi.nlm.nih.gov/subs/biosample/).
Follow the link and start a new BioSample.Fill out the required blanks, and download the excel file called as [Plant_1.0](). Fill out this sheet with your samples information and BioProject IDs. Then upload this file and get submitted. After processed by NCBI, you will download the [attributes file with BioSample accessions]().

### Step3: Submit the [SRA](https://submit.ncbi.nlm.nih.gov/subs/sra/).
Follow the link and start a new SRA submit. You need to download the SRA_metadata sheet and fill out the files according to the atreribute file. Also please link the actural read file with each sample id.

### Step4: Submit with commandline by this [link](https://www.ncbi.nlm.nih.gov/genbank/preloadfiles/):

```
ascp -i /nfs/roc/groups/9/morrellp/shaw0170/SRA/aspera.openssh.txt -QT -l100m -k1 -d /panfs/roc/scratch/SORTED_BRIDG6_FASTQ/fastq_files/SRA_metadata_bridge_6_group_6/*.fastq subasp@upload.ncbi.nlm.nih.gov:uploads/shaw0170@umn.edu_wAwlZ9m1/SUB4498108
```
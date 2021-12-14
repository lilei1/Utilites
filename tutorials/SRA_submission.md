# Objective: This is for submitting the raw reads to the NCBI SRA:


### Step1: Submit the [BioProject](https://submit.ncbi.nlm.nih.gov/subs/bioproject/)
Follow the link and start a new BioProject. Fill out the required blanks and submitted. Once you get submitted and processed by NCBI, you are supposed to get the bioProject number, like PRJNA523236.

### Step2: Submit the [Biosample](https://submit.ncbi.nlm.nih.gov/subs/biosample/).
Follow the link and start a new BioSample.Fill out the required blanks, and download the excel file called as [Plant_1.0](https://github.com/lilei1/Utilites/blob/master/tutorials/plant_1.0.xlsx). Fill out this sheet with your samples information and BioProject IDs. Make sure every sample is unique (unique to the SRA database). ABout the geographic location, they have very strict requirement. So be careful about this. Then upload this file and get submitted. After processed by NCBI, you will download the [attributes file with BioSample accessions](https://github.com/lilei1/Utilites/blob/master/tutorials/attributes.tsv).

### Step3: Submit the [SRA](https://submit.ncbi.nlm.nih.gov/subs/sra/).
Follow the link and start a new SRA submit. You need to download the [SRA_metadata](https://github.com/lilei1/Utilites/blob/master/tutorials/SRA_metadata_bridge_6%20copy%202.xlsx) sheet and fill out the files according to the atreribute file. Also please link the actural read file with each sample id.

### Step4: Submit with commandline by this [link](https://www.ncbi.nlm.nih.gov/genbank/preloadfiles/):

```
ascp -i /nfs/roc/groups/9/morrellp/shaw0170/SRA/aspera.openssh.txt -QT -l100m -k1 -d /panfs/roc/scratch/SORTED_BRIDG6_FASTQ/fastq_files/SRA_metadata_bridge_6_group_6/*.fastq subasp@upload.ncbi.nlm.nih.gov:uploads/shaw0170@umn.edu_wAwlZ9m1/SUB4498108
```

Note: in order to use ascp to submite, you need to download the `ibm-aspera-connect` wiht the commond line as below:

```
wget https://d3gcli72yxqn2z.cloudfront.net/connect_latest/v4/bin/ibm-aspera-connect_4.1.0.46-linux_x86_64.tar.gz

tar -xvf ibm-aspera-connect_4.1.0.46-linux_x86_64.tar.gz

bash ibm-aspera-connect_4.1.0.46-linux_x86_64.sh
Installing IBM Aspera Connect

Deploying IBM Aspera Connect (/global/homes/l/llei2019/.aspera/connect) for the current user only.

Install complete.
(base) ![image](https://user-images.githubusercontent.com/4632690/145939826-5cb12702-a5b7-44e4-a8c7-375956f8f1ac.png)
```
Once you installed and get the notice as above, you can do 
```
cd /global/homes/l/llei2019/.aspera/connect
```
Then run Submit commond line.
Heads up! You need to put your files in a subdirectory under the root:
for example, need to use "subasp@upload.ncbi.nlm.nih.gov:uploads/shaw0170@umn.edu_wAwlZ9m1/SUB4498108" instead of "subasp@upload.ncbi.nlm.nih.gov:uploads/shaw0170@umn.edu_wAwlZ9m1".
Otherwise, they will not allow you to preview the files and get the final submitted.



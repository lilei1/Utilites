#   Install PPH2 stand alone version
It is very hard to make PPH2 run

## Download the PPH2 from this [link](http://genetics.bwh.harvard.edu/pph2/dokuwiki/_media/polyphen-2.2.2r405c.tar.gz)

 Then uncompress ths file
```
tar vxzf polyphen-2.2.2r405b.tar.gz
mv polyphen-2.2.2/ pph2
```
 Set up the enviromental variables:
 ```
  cat >> ~/.bash_profile
  export PPH=/panfs/roc/scratch/llei/pph2
  export PATH="$PATH:$PPH/bin"
  <Ctrl-D>
  source ~/.bash_profile
 ```
## Use MSI perl module and check if those module works

```
module load perl/modules.centos7.5.26.1
```
The check if those modules are installed there:
  - XML::Simple
  - LWP::Simple
  - DBD::SQLite

```
perl -MXML::Simple -e 1
perl -MLWP::Simple -e 1
perl -MDBD::SQLite -e 1
```

##Intall blast
### Note: Blast2.3.1 has problem!!!! I used blast2.7.1

```
cd software/
wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.7.1+-x64-linux.tar.gz
tar vxzf ncbi-blast-2.2.31+-x64-linux.tar.gz
mv ncbi-blast-2.7.1+/* $PPH/blast/
rmdir ncbi-blast-2.7.1+/
```
## Dowloand and set up the databases:

### NON-REDUNDANT SEQUENCE DATABASE(nrdb):

```
cd $PPH/nrdb

wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/uniref/uniref100/uniref100.fasta.gz

gunzip uniref100.fasta.gz

$PPH/update/format_defline.pl uniref100.fasta >uniref100-formatted.fasta

echo "module load perl/modules && /panfs/roc/scratch/llei/pph2/blast/bin/makeblastdb -in /panfs/roc/scratch/llei/pph2/nrdb/uniref100-formatted.fasta -dbtype prot -out /panfs/roc/scratch/llei/pph2/nrdb/uniref100 -parse_seqids"|qsub -l mem=40gb,nodes=1:ppn=7,walltime=24:00:00 -m abe -M llei@umn.edu -N uniref100 -q small
rm -f uniref100.fasta uniref100-formatted.fasta
```

### STRUCTURAL DATABASES

#### pdb

```
cd $PPH/wwwpdb/divided/pdb/
 rsync -rltv --delete-after --port=33444 \
      rsync.wwpdb.org::ftp/data/structures/divided/pdb/ $PPH/wwpdb/divided/pdb/

cd $PPH/wwwpdb/all/pdb/
rsync -rltv --delete-after --port=33444 \
      rsync.wwpdb.org::ftp/data/structures/all/pdb/ $PPH/wwpdb/all/pdb/
```
#### dscp

```
rsync -rltvz --delete-after rsync://rsync.cmbi.ru.nl/dssp/ $PPH/dssp/
```
### run ./pdb2fasta.pl to update the databases:

```
echo "module load perl/modules.centos7.5.26.1 && perl /panfs/roc/scratch/llei/pph2/update/pdb2fasta.pl -l /panfs/roc/scratch/llei/pph2/wwpdb/all/pdb >/panfs/roc/scratch/llei/pph2/pdb2fasta/pdb2fasta.log 2>&1"|qsub -l mem=40gb,nodes=1:ppn=7,walltime=24:00:00 -m abe -M llei@umn.edu -d /panfs/roc/scratch/llei/pph2/pdb2fasta/ -N pdb2fasta -q small
```
It will create those file:

```
pdb.seq
pdb.fragm
pdb.makeblastdb.perf
pdb.makeblastdb.log
pdb.pin
pdb.phr
pdb.psq
pdb.sqlite
pdb2fasta.log
```
### uniprot database:
Create & update combined UniProtKB/Pfam sequence/annotation
databases:

set up the enviromental virables
```
cd /panfs/roc/scratch/llei/uniprot/
myTmp=$(pwd)/tmp
if [ ! -d "$myTmp" ]; then
  mkdir $myTmp
fi
export TMPDIR=$myTmp
export SQLITE_TMPDIR=$myTmp
```
Revise the script [`$PPH/update/uniprot.pl`](https://github.com/lilei1/Utilites/blob/master/script/uniprot.pl)

```
echo "module load perl/modules.centos7.5.26.1 && perl /panfs/roc/scratch/llei/pph2/update/uniprot.pl -n plants"|qsub -l mem=40gb,nodes=1:ppn=7,walltime=24:00:00 -m abe -M llei@umn.edu -d /panfs/roc/scratch/llei/pph2/uniprot -N uniprot -q small

```

### BUILDING POLYPHEN-2

```
#Change into the source code directory:

  $ cd $PPH/src

#Download, build and install all required programs:
module load perl/modules.centos7.5.26.1
  $ make download
  $ make clean
  $ make
  $ make install
```
### CONFIGURING POLYPHEN-2

```
  $ cd $PPH
  $ ./configure
```
### revise the option file
```
cd config
vi option.cnf

REFORGANISM     = Hordeum vulgare
REFORGCOMMON    = plants
MAPGENE         = 0
```
Then evrything should be fine
We can test the data

Creat the sub file and protein fasta file:



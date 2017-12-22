#   Install SIFT stand alone version

Several version of SIFT can not work, including sift6.2.1 and sift4. There are bugs there and hard to figure out the missing pieces.

Tom send me the version sift-5.2.2, and it works, but compile is a little tricky.

### Install perl modules

- Getopt::Std
- POSIX
- Class::Struct
- LWP::Simple
- Tie::IxHash
- DBI
- File::Copy
- List::Util
- File::Basename
- File::Path"

MSI (run module load perl/modules) has majorit of those modules except `Tie::IxHash`

- Download and install `Tie::IxHash`

```
wget http://search.cpan.org/CPAN/authors/id/C/CH/CHORNY/Tie-IxHash-1.23.tar.gz

tar -zxvf ~/downloads/Tie-IxHash-1.23.tar.gz

cd ~/software/Tie-IxHash-1.23

perl Makefile.PL PREFIX=/panfs/roc/groups/9/morrellp/llei/software/perl5lib

make
make test
make install

vi ~/.bash_profile
#add the staement below in the bash_profile
export PERL5LIB=/panfs/roc/groups/9/morrellp/llei/software/perl5lib/share/perl5:$PERL5LIB
:qw
source ~/.bash_profile

#check if this module installed:
perl -MTie::IxHash -e 1

#If no error, that suggests this module installed
```
### Download and install `ncbi-blast-2.2.29+`

### Setting paths

    Navigate to <SIFT_HOME>/config

    Open config_env.txt in a text editor, and set the paths accordingly

    For BLIMPS_HOME, please set it to <SIFT_HOME>/blimps

    Run the following command:

    perl setup_env.pl linux

### Go to src/, and follow README directions to compile the source code
```
    vi cccb.csh
    #check if the path is correct
    csh cccb.csh choose_seqs_via_psiblastseedmedian
    csh cccb.csh clump_output_alignedseq
    csh cccb.csh consensus_to_seq
    csh cccb.csh info_on_seqs
    csh cccb.csh psiblast_res_to_fasta_dbpairwise
    csh cccb.csh seqs_from_psiblast_res
```
### test

```
echo "module load perl/modules && csh /panfs/roc/groups/9/morrellp/llei/software/sift5.2.2/bin/SIFT_for_submitting_fasta_seq.csh /panfs/roc/groups/9/morrellp/llei/software/sift5.2.2/test/lacI.fasta /panfs/roc/scratch/llei/uniref_pro/uniref90.fa /panfs/roc/groups/9/morrellp/llei/software/sift5.2.2/test/lacI.subst"|qsub -l mem=44gb,nodes=1:ppn=7,walltime=24:00:00 -m abe -M llei@umn.edu -N filter_out_indels_inversion -q small
4649463.mesabim3.msi.umn.edu
```
It works, but there is error:

```
Warning: lcl|Query_1 gi|2506562|sp|P03023|LACI_ECOLI   LACTOSE OPERON REPRESSOR: Warning: Composition-based score adjustment conditioned on sequence properties and unconditional composition-based score adjustment is not supported with PSSMs, resetting to default value of standard composition-based statistics 
sh: line 0: unalias: rm: not found
Warning: load_frequencies: Unable to open frequency file: /panfs/roc/groups/9/morrellp/llei/software/sift5.2.2/blimps/docs/default.amino.f/panfs/roc/groups/9/morrellp/llei/software/sift5.2.2/blimps/docs/default.qij
```

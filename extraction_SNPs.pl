#!/usr/bin/perl
##by Li Lei, 20160613, in St.Paul;
#this is to extract markers Chaochih is interested in!
#usage: ./extraction_SNPs.pl ../data/WBDC_genotype_count_transposed#.txt ../data/all_2H_SNP_namesOnly.txt >all_2H_SNP_WBDC_genotype_count.txt
use strict;
use warnings;
use Data::Dumper;
my ($file1, $file2) = @ARGV;

my %gidhash;


open(SNPID,  "$file1") or die "Could not open $file1";
my $header = <SNPID>;
print "$header";
foreach my $row (<SNPID>){
        chomp $row;
        my @rtemp = split(/\t/,$row);
        $gidhash{$rtemp[0]}=$row;
        #print "$rtemp[0]\n";
}
close (SNPID);
#print Dumper(\%gidhash);
open(OUT,  "$file2") or die "Could not open $file2";

foreach my $row (<OUT>){
        chomp $row;
        my @rtemp1 = split(/\t/,$row);
           #print "$rtemp1[0]\n";
           my $gene = $rtemp1[0];
              $gene =~ s/^\s+|\s+$|^\t+|\t+$//g;
        if(exists $gidhash{$gene}){
           print "$gidhash{$gene}\n";
        }
        else{
           print "$gene\tNOT_EXISTS\n";
        }
}
close (OUT);

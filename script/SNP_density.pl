#!/usr/bin/perl
##by Li Lei, 20170728, in St.Paul;
#this is to calculate the SNPs density for each windowns:
#You need to prepared two input files: windowns file and the vcf files in the same chromosome:
#usage: ./SNP_density.pl vcf windows 
use strict;
use warnings;

my ($file1, $file2) = @ARGV;

my %hash; #define a hash to store the positions for each SNP;
open(OUT,  "$file1") or die "Could not open $file1";
foreach my $row (<OUT>){
        chomp $row;
        next if $row =~ /^#/; #skip all of the lines starting with #;
        my @rtemp1 = split(/\t/,$row);
           #print "$rtemp1[0]\n";
           $hash{$rtemp1[2]} = $rtemp1[1]; #key is the SNP id and value is the position     
}
close (OUT);


open(SNPID,  "$file2") or die "Could not open $file2";
#my $header = <SNPID>;
print "chr\twinS\twinE\tSNPs\n";
foreach my $row (<SNPID>){
        chomp $row;
        my @rtemp = split(/\t/,$row);
        my $chr = $rtemp[0]; #chr
        my $winS = $rtemp[1]; #win start
        my $winE = $rtemp[2]; #win end
        #print "$winS\t$winE\n";
        my $count = 0;
        foreach my $key (keys %hash){
          #print "$hash{$key}\n";
                if ($hash{$key} < $winS){
                    next;
                }
                elsif($hash{$key} >= $winS && $hash{$key} <= $winE){
                      $count++;
                }
                else{
                    next;
                }

        }
        print "$chr\t$winS\t$winE\t$count\n";
}
close (SNPID);
#print Dumper(\%gidhash);

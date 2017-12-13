#!/usr/bin/env python

#Written by Li Lei 2017/12/12 
#required python3
#This is for calculate the indel length for each locus from vcf file called with GATK

import sys
print ("\t".join(["chr","pos","length_max_indel"])) #print header

with open(sys.argv[1]) as f:
	for line in f:
		if line.startswith('#'): #ignored the header of vcf file
			continue
		else:
			tmp = line.strip().split('\t')
			alt = tmp[4].strip().split(',')
			ref = tmp[3]
			max_alt = max(alt, key=len) #find the element with max length
			if len(ref) > len(max_alt):#if statement to find the longer indels of the reference and alternative alleles
				indel_len = len(ref)
			else:
				indel_len = len(max_alt)
			#print (tmp[1])
			#print (indel_len)
			#print ("%s\t%s" % (tmp[0], tmp[1],indel_len))
			print ("\t".join([str(tmp[0]), str(tmp[1]),str(indel_len)]))

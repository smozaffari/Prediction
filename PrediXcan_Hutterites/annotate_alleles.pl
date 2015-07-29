#!usr/bin/env/perl

#given CGI ids and position of SNP, will provide chromosome, rs id, minor and major allele, and MAF 

use strict;
use warnings;

my $filename = $ARGV[0];

my %rs;
my %maf;
my %maj;
my %min;
my %chr;

open (ANN, "/group/ober-resources/users/cigartua/Hutterite_annotation/all_imputed_cgi.annovar_plink_annotations.hg19_multianno.txt") || die "nope: $!";
my $f = <ANN>;
while (my $line = <ANN>) {
    my @line = split "\t", $line;
    my $fakers = $line[44];
    $rs{$fakers} = $line[14];
    $maf{$fakers} = $line[48];
    $maj{$fakers} = $line[47];
    $min{$fakers} = $line[46];
    if ($min{$fakers} =~ /[0-9]/) {
	if ($maj{$fakers} = $line[4]) {
	    $min{$fakers} = $line[3];
	} elsif ($maj{$fakers} = $line[3]) {
	    $min{$fakers} = $line[4];
	}
    } 
    $line[0]=~ s/\D//g;
    $chr{$fakers} = $line[0];
}

#open (SNP, ">SNPlist.txt") || die "nope: $!"; 
#SNPs to keep
#open (PRIV, ">SNP_Huttonly.txt") || die "nope: $!";
#SNPs to remove

open (NEW, ">new_annotated_$filename") || die "nope: $!";
open (FIL, "$filename") || die "nope: $!";
while (my $line = <FIL>) {
    chomp $line;
    my @line = split "\t", $line;
    my $fakers = $line[1];
    if ($rs{$fakers}) {
	print NEW (join "\t", $chr{$fakers}, $rs{$fakers},"0", $line[1], $min{$fakers}, $maj{$fakers},$maf{$fakers});
	print NEW ("\n");
#	print SNP ("$line[1]\t$rs{$fakers}\n");
#    } else {
#	print NEW (join "\t", "NA", @line);    
#	print PRIV ("$line[1]\n");
    }
}
close (NEW);
close (FIL);
close (ANN);
#close (PRIV);
#close (SNP);

#!usr/bin/env/perl

use strict;
use warnings;

my $filename = $ARGV[0];

my %rs;
my %maf;

open (ANN, "/group/ober-resources/users/cigartua/Hutterite_annotation/all_imputed_cgi.annovar_plink_annotations.hg19_multianno.txt") || die "nope: $!";
my $f = <ANN>;
while (my $line = <ANN>) {
    my @line = split "\t", $line;
    my $fakers = $line[44];
    $rs{$fakers} = $line[14];
    $maf{$fakers} = $line[48];
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
	print NEW (join "\t",$line[0],$rs{$fakers}, $line[2], $line[3], $line[4], $line[5], $maf{$fakers});
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

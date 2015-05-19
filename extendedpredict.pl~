#!usr/bin/env/perl

use strict;
use warnings;

my %fev;
my %rel;
my %family;
my %mom;
my %dad;
my %pred;
my %sex;

open (PHEN, "/group/ober-resources/users/smozaffari/Prediction/data/Allphenotypes.fam") || die " nope: !";
#grab FEV1/FVC phenotypes for everyone
while (my $line = <PHEN>) {
    my @line = split " ", $line;
    my $id = $line[0];
    my $fphen = $line[9];
    $fev{$id} = $fphen;
}
close (PHEN);

open (REL, "/group/ober-resources/users/smozaffari/Prediction/data/relatedness") || die "nope: !";
#grab relatedness values between two individuals
while (my $line = <REL>) {
    chomp $line;
    my @line = split "\t", $line;
    my $id1 = $line[0];
    my $id2 = $line[1];
    $rel{$id1}{$id2} = $line[2];
    $rel{$id2}{$id1} = $line[2];
}
close (REL);

open (OUT, ">/group/ober-resources/users/smozaffari/Prediction/results/fevparents") || die "nope: $!";
print OUT "IND\tSEX\tDAD\tDFEV1/FVC\tDREL\tMOM\tMFEV1/FVC\tMREL\tPRED\tOBS\n";

open (FAM, "/group/ober-resources/users/smozaffari/Prediction/data/famcolumns") || die "nope: $!";
#make trios to test prediction using parents
while (my $line = <FAM>) {
    my @line = split " ", $line;
    my $ind = $line[1];
    my $mom = $line[3];
    my $dad = $line[2];
    $mom{$ind} = $mom;
    $dad{$ind} = $dad;
    $family{$dad}{$mom} = $ind;
    $sex{$ind} = $line[4];
#foreach my $d (sort keys %family) {
    #for my $m (sort keys %{ $family{$d} } ) {
	#my $ind = $family{$d}{$m};
    if ($fev{$dad}) {
	if ($fev{$mom}) {
	    $pred{$ind} = ($rel{$ind}{$dad})*($fev{$dad}) + ($rel{$ind}{$mom})*($fev{$mom});
	    print "$ind\t$dad\t$mom\n";
	    print OUT "$family{$dad}{$mom}\t$sex{$ind}\t$dad\t$fev{$dad}\t$rel{$ind}{$dad}\t$mom\t$fev{$mom}\t$rel{$ind}{$mom}\t$pred{$ind}\t$fev{$ind}\n";
	}
    }
}
close (FAM);
close (OUT);

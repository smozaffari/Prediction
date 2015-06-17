#!usr/bin/env/perl

use strict;
use warnings;

my %fev;
my %rel;

my %point;
my @cutoff =(0.002, 0.0078, 0.0313, 0.0625, 0.0938, 0.1, 0.125, 0.2, 0.25, 0.3, 0.375, 0.4, 0.5, 0.6);

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
    if ($id1 != $id2) {
	foreach my $kinship (@cutoff) {
	    if ($line[2] > $kinship) {
		push @{ $point{$kinship}{$id1} }, $id2;
		push @{ $point{$kinship}{$id2} }, $id1;
	    }
	}
    }
}
close (REL);

foreach my $k (sort keys %point) {
    open (OUT, ">/group/ober-resources/users/smozaffari/Prediction/results/fev1fvc_bykinship_$k") || die "nope: $!";
    open (NEF, ">/group/ober-resources/users/smozaffari/Prediction/results/fev1fvc_bykinship_ids_$k")|| die "nop: $!";
    print OUT "Individual\ttotalrelatives\tPred\tObs\n";
    print NEF "Individual\trel#\trelative\tfev_relative\tkinship\tPred\tObs";
    for my $person (keys %{ $point{$k} } ) {
	print OUT ("$person: ");
	my $sum=0;
	my $pred=0;
	my $count=0;
	for my $i (0..$#{ $point{$k}{$person} } ) {
	    my $relative = $point{$k}{$person}[$i];
	    print ("$person $relative $rel{$person}{$relative}\n");
	    if ($rel{$person}{$relative} != "NA") {
		$sum = $sum + $rel{$person}{$relative};
		$count = $count + 1;
	    }
	}
	for my $i (0.. $#{ $point{$k}{$person} } ) {
	    my $relative = $point{$k}{$person}[$i];
	    print NEF "$person $i $relative\t$fev{$relative}\t";
	    print NEF "$rel{$person}{$relative}\t";
	    if ($rel{$person}{$relative} != "NA") {	    
		$pred = $pred + (($fev{$relative})*($rel{$person}{$relative}))/$sum;
	    }
	}
	print OUT ("$count\t$pred\t$fev{$person}\n"); 
	print NEF ("$pred\t$fev{$person}\n");
    }
    close (OUT);
    close(NEF);
}

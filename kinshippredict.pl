#!usr/bin/env/perl

use strict;
use warnings;

my %fev;
my %rel;

my %point0020id;
my %point0020rel;
my %point0078id;
my %point0078rel;
my %point0313id;
my %point0313rel;
my %point0625id;
my %point0625rel;
my %point0938id;
my %point0938rel;
my %point1id;
my %point1rel;
my %point125id;
my %point125rel;
my %point2id;
my %point2rel;
my %point25id;
my %point25rel;
my %point3id;
my %point3rel;
my %point375id;
my %point375rel;
my %point4id;
my %point4rel;
my %point5id;
my %point5rel;

my %kin;

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
    if ($line[2] > 0.0020) {
        push @{$point0020id{$id1} }, $id2;
	push @{$point0020id{$id2} }, $id1;
	push @{$point0020rel{$id1} }, $line[2];
	push @{$point0020rel{$id2} }, $line[2];
	if ($line[2] > 0.0078) {
	    push @{ $point0078id{$id1} }, $id2;
	    push @{ $point0078id{$id2} }, $id1;
	    push @{ $point0078rel{$id1} }, $line[2];
	    push @{ $point0078rel{$id2} }, $line[2];
	    if ($line[2] > 0.0313) {
		push @{$point0313id{$id1} }, $id2;
		push @{$point0313id{$id2} }, $id1;
		push @{$point0313rel{$id1} }, $line[2];
		push @{$point0313rel{$id2} }, $line[2];
		if ($line[2] > 0.0625) {
		    push @{$point0625id{$id1} }, $id2;
		    push @{$point0625id{$id2} }, $id1;
		    push @{$point0625rel{$id1} }, $line[2];
		    push @{$point0625rel{$id2} }, $line[2];
		    if ($line[2] > 0.0938) {
			push @{$point0938id{$id1} }, $id2;
			push @{$point0938id{$id2} }, $id1;
			push @{$point0938rel{$id1} }, $line[2];
			push @{$point0938rel{$id2} }, $line[2];
			if ($line[2] > 0.1) {
			    push @{$point1id{$id1} }, $id2;
			    push @{$point1id{$id2} }, $id1;
			    push @{$point1rel{$id1} }, $line[2];
			    push @{$point1rel{$id2} }, $line[2];
			    if ($line[2] > 0.125) {
				push @{$point125id{$id1} }, $id2;
				push @{$point125id{$id2} }, $id1;
				push @{$point125rel{$id1} }, $line[2];
				push @{$point125rel{$id2} }, $line[2];
				if ($line[2] > 0.2) {
				    push @{$point2id{$id1} }, $id2;
				    push @{$point2id{$id2} }, $id1;
				    push @{$point2rel{$id1} }, $line[2];
				    push @{$point2rel{$id2} }, $line[2];
				    if ($line[2] > 0.25) {
					push @{$point25id{$id1} }, $id2;
					push @{$point25id{$id2} }, $id1;
					push @{$point25rel{$id1} }, $line[2];
					push @{$point25rel{$id2} }, $line[2];
					if ($line[2] > 0.3) {
					    push @{$point3id{$id1} }, $id2;
					    push @{$point3id{$id2} }, $id1;
					    push @{$point3rel{$id1} }, $line[2];
					    push @{$point3rel{$id2} }, $line[2];
					    if ($line[2] > 0.375) {
						push @{$point375id{$id1} }, $id2;
						push @{$point375id{$id2} }, $id1;
						push @{$point375rel{$id1} }, $line[2];
						push @{$point375rel{$id2} }, $line[2];
						if ($line[2] > 0.4) {
						    push @{$point4id{$id1} }, $id2;
						    push @{$point4id{$id2} }, $id1;
						    push @{$point4rel{$id1} }, $line[2];
						    push @{$point4rel{$id2} }, $line[2];
						    if ($line[2] > 0.5) {
							push @{$point5id{$id1} }, $id2;
							push @{$point5id{$id2} }, $id1;
							push @{$point5rel{$id1} }, $line[2];
							push @{$point5rel{$id2} }, $line[2];
						    }
						}
					    }
					}
				    }
				}
			    }
			}
		    }
		}
	    }
	}
    }
}
close (REL);


open (OUT, ">/group/ober-resources/users/smozaffari/Prediction/results/fev1fvc_bykinship") || die "nope: $!";
open (NEF, ">/group/ober-resources/users/smozaffari/Prediction/results/fev1fvc_bykinship_ids")|| die "nop: $!";
print OUT "Individual\ttotalrelatives\tPred\tObs\n";
print NEF "Individual\trel#\trelative\tfev_relative\tkinship\tPred\tObs";
for my $people (keys %point0020id) {
    print OUT ("$people: ");
    my $sum=0;
    my $pred=0;
    my $count=0;
    for my $i (0..$#{ $point0020id{$people} } ) {
	$sum = $sum + $point0020rel{$people}[$i];
	$count = $count + 1;
    }
    for my $i (0.. $#{ $point0020id{$people} } ) {
	my $relative = $point0020id{$people}[$i];
	print NEF "$people $i $relative\t$fev{$relative}\t";
	print NEF "$point0020rel{$people}[$i]\t";
	$pred = $pred + (($fev{$relative})*($point0020rel{$people}[$i]))/$sum;
    }
    print OUT ("$count\t$pred\t$fev{$people}\n"); 
    print NEF ("$pred\t$fev{$people}\n");
}

close (OUT);
close(NEF);

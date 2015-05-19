#!usr/bin/env/perl

#testing bitbucket

use strict;
use warnings;

my %fev;
my %rel;
my %family;
my %child;
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
}
close (REL);

open (FAM, "/group/ober-resources/users/smozaffari/Prediction/results/fevparents") || die "nope: $!";
my $first = <FAM>;
while (my $line = <FAM>) {
    my @line = split "\t", $line;
    my $ind = $line[0];
    my $mom = $line[5];
    my $dad = $line[2];
    #if another child of the same mother already exists
    if ($child{$mom}[0] ) {
	my $person = $child{$mom}[0]; #take that previous child
#	push @{ $family{$ind} }, @{ $family{$person}}; #add previous child's relatives to new child's relatives
#	for my $j (0..$#{ $family{$person} } ) { #for each relative that was there previously,
#	    my $relative = $family{$person}[$j];
#	    push @{ $kin{$ind} }, $rel{$ind}{$relative}; #calculate this person's kinship with that relative
#	}

	push @{ $family{$ind} }, $mom;
	push @{ $family{$ind} }, $dad; #add dad to list of child's family                                                                                                                                                                                                    
        push @{ $kin{$ind} }, $rel{$mom}{$ind}; #in respective order, add mom and child's relation to kinship values                                                                                                                                                          
        push @{ $kin{$ind} }, $rel{$dad}{$ind}; #in respective order, add dad and child's relation to kinship values
        
	for my $m (0..$#{ $child{$mom}}) { #for each previous child
	    my $childx= $child{$mom}[$m]; 
	    push @{ $family{$childx} }, $ind; #add this new person to the previous child's family 
	    push @{ $family{$ind} }, $childx; #add the previous child to the new person's family                                                                                                                                                                              
	    push @{ $kin{$childx} }, $rel{$childx}{$ind}; #add the new person's kinship to the previous child's kinship of related individuals                                                                                                                                
	    push @{ $kin{$ind} }, $rel{$childx}{$ind}; #add the previous child's kinship to the new person's kinship of related individuals        
	}	
	push @{ $child{$mom}}, $ind;
    } else { #if another child of the same mother does not exist
	$child{$mom}[0] = $ind; #count this child as the first one/only one for now.
	push @{ $family{$ind} }, $mom; #add mom to list of child's family
	push @{ $family{$ind} }, $dad; #add dad to list of child's family
	push @{ $kin{$ind} }, $rel{$mom}{$ind}; #in respective order, add mom and child's relation to kinship values
	push @{ $kin{$ind} }, $rel{$dad}{$ind}; #in respective order, add dad and child's relation to kinship values
    }
    $sex{$ind} = $line[4];
#foreach my $d (sort keys %family) {
    #for my $m (sort keys %{ $family{$d} } ) {
	#my $ind = $family{$d}{$m};
}
close (FAM);

open (OUT, ">/group/ober-resources/users/smozaffari/Prediction/results/fev1fvc_siblings_parents") || die "nope: $!";
open (NEF, ">/group/ober-resources/users/smozaffari/Prediction/results/fev1fvc_siblings_parents_ids")|| die "nop: $!";
print OUT "Individual\ttotalrelatives\tPred\tObs\n";
print NEF "Individual\trel#\trelative\tfev_relative\tkinship\tPred\tObs";
for my $people (keys %family) {
    print OUT ("$people: ");
    my $sum=0;
    my $pred=0;
    my $count=0;
    for my $i (0..$#{ $family{$people} } ) {
	$sum = $sum + $kin{$people}[$i];
	$count = $count + 1;
    }
    for my $i (0.. $#{ $family{$people} } ) {
	my $relative = $family{$people}[$i];
	print NEF "$people $i $relative\t$fev{$relative}\t";
	print NEF "$kin{$people}[$i]\t";
	$pred = $pred + (($fev{$relative})*($kin{$people}[$i]))/$sum;
    }
    print OUT ("$count\t$pred\t$fev{$people}\n"); 
    print NEF ("$pred\t$fev{$people}\n");
}

close (OUT);

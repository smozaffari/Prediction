#!usr/bin/env/perl

use strict;
use warnings;

my %fev;
my %rel;

open (PHEN, "/group/ober-resources/users/smozaffari/Prediction/data/Allphenotypes.fam") || die " nope: !";
#grab FEV1/FVC phenotypes for everyone
while (my $line = <PHEN>) {
    my @line = split " ", $line;
    my $id = $line[0];
    my $fphen = $line[9];
    $fev{$id} = $fphen;
}
close (PHEN);

open (OUT, ">/group/ober-resources/users/smozaffari/Prediction/results/fev_pairs") || die "nope: $!";
print OUT "IND1\tFEV1/FVC2\tIND2\tMFEV1/FVC2\tREL\n";

open (REL, "/group/ober-resources/users/smozaffari/Prediction/data/relatedness") || die "nope: !";
#grab relatedness values between two individuals
while (my $line = <REL>) {
    chomp $line;
    my @line = split "\t", $line;
    my $id1 = $line[0];
    my $id2 = $line[1];
    $rel{$id1}{$id2} = $line[2];
    $rel{$id2}{$id1} = $line[2];
    print OUT ("$id1\t$fev{$id1}\t$id2\t$fev{$id2}\t$line[2]\n");
}
close (REL);
close (OUT);


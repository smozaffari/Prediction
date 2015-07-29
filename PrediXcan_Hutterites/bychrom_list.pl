#!/usr/bin/env/perl

use strict;
use warnings;

my %count;
my %start;
my %stop;

open (BIM, "/group/ober-resources/users/smozaffari/Prediction/data/test/SNPinfo.bim") || die "nope: $!";
while (my $line = <BIM>) {
    chomp $line;
    my @line = split "\t", $line;
    foreach my $str ($line[0]) {
	$count {$str}++;
    }
}
$stop{0} = 6;

foreach my $str ( sort {$a <=> $b} keys %count) {
    $start{$str} = $stop{$str-1}+1;
    $stop{$str} = $count{$str}+ $start{$str};
    print "$str $count{$str}   $start{$str}-$stop{$str}\n";
}
close(BIM);

foreach my $str ( sort keys %count) {
    my $a = $start{$str};
    my $b = $stop{$str};
    my $head = ($count{$str} + $stop{$str-1} - 5);
#    my $cmd = ('head -'.$head.' SNPlist_hapmap_rsids.txt | tail -'.$count{$str}.' > chr'.$str.'.SNPlist.txt');
    my $cmd = ('head -'.$head.' SNPinfo.bim | tail -'.$count{$str}.' > chr'.$str.'.SNPinfo.txt');    
    print ($cmd);
    print ("\n");
#    system($cmd);
}

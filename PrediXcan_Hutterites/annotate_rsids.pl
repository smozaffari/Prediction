#!usr/bin/env/perl

#given rsids in first column and location , will print new fill with CGI id in second column

use strict;
use warnings;

my $filename = $ARGV[0];

my %fakers;
my %maf;
my %maj;
my %min;
my %chr;

open (ANN, "/group/ober-resources/users/cigartua/Hutterite_annotation/all_imputed_cgi.annovar_plink_annotations.hg19_multianno.txt") || die "nope: $!";
my $f = <ANN>;
while (my $line = <ANN>) {
    my @line = split "\t", $line;
    my $rs = $line[14];
    $fakers{$rs} = $line[44];
    $maf{$rs} = $line[48];
    $maj{$rs} = $line[47];
    $min{$rs} = $line[46];
    $line[0] =~ s/\D//g;
    $chr{$rs} = $line[0];
}

open (PRIV, ">notinHutterite");
open (NEW, ">inHutt_$filename") || die "nope: $!";
open (FIL, "$filename") || die "nope: $!";
while (my $line = <FIL>) {
    chomp $line;
    my @line = split "\t", $line;
    my $rs = $line[0];
#usually line[1];
    if ($fakers{$rs}) {
#line[0] in output
	print NEW (join "\t",$rs, $line[2], $line[3], $maj{$rs}, $min{$rs}, $maf{$rs});
	print NEW ("\n");
    } else {
	print PRIV (join "\t", $line[0], $rs,  $maf{$rs});
	print PRIV ("\n");
    }
    
}
close (NEW);
close (FIL);
close (ANN);
close (PRIV);

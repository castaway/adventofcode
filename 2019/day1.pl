#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
my $total = 0;
my @lines = <>;

sub mass {
    my $line = shift;
    $line /= 3;
    $line = int($line);
    $line-= 2;
    return 0 if $line <= 0;
    $line += mass($line);
}

$total += mass($_) for (@lines);

print $total;

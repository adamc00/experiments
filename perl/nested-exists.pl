#!/usr/bin/env perl

use strict;
use warnings;

my $ref;

$ref->[0]{z}{y} = "Z";

if (exists $ref->[0]{z}{y} ) {
    print "$ref->[0]{z}{y}\n";
}
else {
    print "Doesn't exist\n";
}
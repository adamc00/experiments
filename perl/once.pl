#!/usr/bin/env perl

use v5.10;
use warnings;
use strict;

my $value;

say set_random_range(0, 10);
say set_random_range(0, 10);

sub set_once {

  my ($sub_ref) = @_;

  if (!defined $value) {
    $value = $sub_ref->();
  }

  return $value;

}

sub get_random_range {

  my ($min, $max) = @_;

  return $min + int(rand($max - $min + 1));

}

sub set_random_range {

  my ($min, $max) = @_;

  my $sub_ref = sub {
    return get_random_range($min, $max);
  };

  return set_once($sub_ref);

}

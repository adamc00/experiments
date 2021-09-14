#!/usr/bin/env perl

use v5.10;
use warnings;
use strict;

my $value;

say set_random_range(2, 4);
say set_random_range(4, 8);

sub set_once {

  my ($sub_ref) = @_;

  if (!defined $value) {
    $value = $sub_ref->();
  }

  return $value;

}

sub get_random_range {

  my ($min, $max) = @_;

  return ($min * $max);

}

sub set_random_range {

  my ($min, $max) = @_;

  my $sub_ref = sub {
    return get_random_range($min, $max);
  };

  return set_once($sub_ref);

}

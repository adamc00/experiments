#!/usr/bin/env perl

use v5.10;
use warnings;
use strict;

my $failures = 0;

my @subjects = (
  {text => 'This is an example subject line [SEC=UNOFFICIAL]', result => 'allow'},
  {text => 'This is an example subject line [SEC=OFFICIAL]', result => 'allow'},
  {text => 'This is an example subject line [SEC=OFFICIAL:Sensitive]', result => 'deny'},
  {text => 'This is an example subject line [SEC=OFFICIAL: Sensitive]', result => 'deny'},
  {text => 'This is an example subject line [SEC=OFFICIAL:Sensitive, ACCESS=Legal-Privilege]', result => 'deny'},
  {text => 'This is an example subject line [SEC=OFFICIAL:Sensitive, CAVEAT=SH:NATIONAL-CABINET]', result => 'deny'},
  {text => 'This is an example subject line [SEC=PROTECTED, EXPIRES=2019-07-01, DOWNTO=OFFICIAL]', result => 'deny'},
  {text => 'This is an example subject line [SEC=SECRET, CAVEAT=SH:ACCOUNTABLE-MATERIAL, CAVEAT=RI:AUSTEO]', result => 'deny'},
);

my @headers = (
  {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=UNOFFICIAL,\nORIGIN=neville.jones\@entity.gov.au", result => 'allow'},
  {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=OFFICIAL,\nORIGIN=neville.jones\@entity.gov.au", result => 'allow'},
  {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=OFFICIAL:Sensitive,\nORIGIN=neville.jones\@entity.gov.au", result => 'deny'},
  {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=OFFICIAL: Sensitive,\nORIGIN=neville.jones\@entity.gov.au", result => 'deny'},
  {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=OFFICIAL:Sensitive,\nACCESS=Legal-Privilege,\nORIGIN=neville.jones\@entity.gov.au", result => 'deny'},
  {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=OFFICIAL:Sensitive,\nCAVEAT=SH:NATIONAL-CABINET,\nORIGIN=neville.jones\@entity.gov.au", result => 'deny'},
  {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=PROTECTED,\nEXPIRES=2019-07-01,\nDOWNTO=OFFICIAL,\nORIGIN=neville.jones\@entity.gov.au", result => 'deny'},
  {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=SECRET,\nCAVEAT=SH:ACCOUNTABLE-MATERIAL,\nCAVEAT=RI:AUSTEO,\nORIGIN=neville.jones\@entity.gov.au", result => 'deny'},
);

say "### $0\n";

say "#### Subjects\n";
say '```';

foreach my $subject (@subjects) {

  my $text = $subject->{text};
  my $desired_result = $subject->{result};

  my $result = "undefined";
  if ( $text =~ /\[SEC=(OFFICIAL:\s*Sensitive|PROTECTED|SECRET|TOP-SECRET)/ ) {
    $result = 'deny';
  }
  else {
    $result = 'allow';
  }

  if ( $result eq $desired_result) {
    say "pass:\t$text ($result)\n";
  }
  else {
    $failures++;
    say "fail:\t$text ('$result' desired '$desired_result')\n";
  }

}
say '```';

say "\n#### Headers\n";
say '```';

foreach my $header (@headers) {

  my $text = $header->{text};
  my $desired_result = $header->{result};

  my $result = "undefined";
  if ( $text =~ /X-Protective-Marking:.*NS=gov\.au.*SEC=(OFFICIAL:\s*Sensitive|PROTECTED|SECRET|TOP-SECRET)/s ) {
    $result = 'deny';
  }
  else {
    $result = 'allow';
  }

  if ( $result eq $desired_result) {
    say "pass:\t$text ($result)\n";
  }
  else {
    $failures++;
    say "fail:\t$text ('$result' desired '$desired_result')\n";
  }

}
say '```';

say"\n#### Results\n";
say "**Failures: $failures**\n";
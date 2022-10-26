#!/usr/bin/env perl

use v5.10;
use warnings;
use strict;

use re 'regexp_pattern';

my $failures = 0;

my @marking_sources = (
  {
    source  => 'Subject',
    regex   => qr /\[SEC=(OFFICIAL:\s*Sensitive|PROTECTED|SECRET|TOP-SECRET)/,
    strings => [
      {text => 'This is an example subject line [SEC=UNOFFICIAL]', result => 'allow'},
      {text => 'This is an example subject line [SEC=OFFICIAL]', result => 'allow'},
      {text => 'This is an example subject line [SEC=OFFICIAL:Sensitive]', result => 'deny'},
      {text => 'This is an example subject line [SEC=OFFICIAL: Sensitive]', result => 'deny'},
      {text => 'This is an example subject line [SEC=OFFICIAL:Sensitive, ACCESS=Legal-Privilege]', result => 'deny'},
      {text => 'This is an example subject line [SEC=OFFICIAL:Sensitive, CAVEAT=SH:NATIONAL-CABINET]', result => 'deny'},
      {text => 'This is an example subject line [SEC=PROTECTED, EXPIRES=2019-07-01, DOWNTO=OFFICIAL]', result => 'deny'},
      {text => 'This is an example subject line [SEC=SECRET, CAVEAT=SH:ACCOUNTABLE-MATERIAL, CAVEAT=RI:AUSTEO]', result => 'deny'},
      {text => 'This is an example subject line [SEC=TOP-SECRET]', result => 'deny'},
    ]
  },
  {
    source  => 'Header',
    regex   => qr /X-Protective-Marking:(\n|.)*NS=gov\.au(\n|.)*SEC=(OFFICIAL:\s*Sensitive|PROTECTED|SECRET|TOP-SECRET)/,
    strings => [
      {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=UNOFFICIAL,\nORIGIN=neville.jones\@entity.gov.au", result => 'allow'},
      {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=OFFICIAL,\nORIGIN=neville.jones\@entity.gov.au", result => 'allow'},
      {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=OFFICIAL:Sensitive,\nORIGIN=neville.jones\@entity.gov.au", result => 'deny'},
      {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=OFFICIAL: Sensitive,\nORIGIN=neville.jones\@entity.gov.au", result => 'deny'},
      {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=OFFICIAL:Sensitive,\nACCESS=Legal-Privilege,\nORIGIN=neville.jones\@entity.gov.au", result => 'deny'},
      {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=OFFICIAL:Sensitive,\nCAVEAT=SH:NATIONAL-CABINET,\nORIGIN=neville.jones\@entity.gov.au", result => 'deny'},
      {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=PROTECTED,\nEXPIRES=2019-07-01,\nDOWNTO=OFFICIAL,\nORIGIN=neville.jones\@entity.gov.au", result => 'deny'},
      {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=SECRET,\nCAVEAT=SH:ACCOUNTABLE-MATERIAL,\nCAVEAT=RI:AUSTEO,\nORIGIN=neville.jones\@entity.gov.au", result => 'deny'},
      {text => "X-Protective-Marking: VER=2018.4, NS=gov.au,\nSEC=TOP-SECRET,\nORIGIN=neville.jones\@entity.gov.au", result => 'deny'},
    ]
  },
);

say "### $0\n";

foreach my $marking_source (@marking_sources) {

  say "#### $marking_source->{source}\n";

  my ($pat, $mods) = regexp_pattern($marking_source->{regex});

  say "regex: $pat\n";


  say '```';

  foreach my $string (@{$marking_source->{strings}}) {

    my $result = "allow";
    if ( $string->{text} =~ $marking_source->{regex} ) {
      $result = 'deny';
    }

    if ( $result eq $string->{result}) {
      say "pass:\t$string->{text} ($result)\n";
    }
    else {
      $failures++;
      say "fail:\t$string->{text} ('$result' desired '$string->{result}')\n";
    }
  }

  say "```\n";

}

say"#### Results\n";
say "**Failures: $failures**\n";
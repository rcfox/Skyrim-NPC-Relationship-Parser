#!/usr/bin/perl
use 5.010_000;
use strict;
use warnings;
use File::Slurp;

my @names_file = read_file($ARGV[0]);
my @relationships_file = read_file($ARGV[1]);

my %names;
my %relationships;

for(@names_file) {
	if(/FormID: (.*?)\t\s*(.*?)\t\s*(.*?)\t\s*(.*)/) {
		my($id,$alias,$type,$fullname) = ($1,$2,$3,$4);
		$names{$alias}{name} = $fullname;
	}
}

for(@relationships_file) {
	if(/(.*?)\t\s*(.*?)\t\s*(.*?)\t\s*(.*?)\t\s*(.*?)\t\s*(.*?)\t\s*(.*)/) {
		my($id,$alias1,$personality1,$alias2,$personality2,$level,$type) = ($1,$2,$3,$4,$5,$6,$7);
		$relationships{$id}{alias1} = $alias1;
		$relationships{$id}{alias2} = $alias2;
		$relationships{$id}{level} = $level;
		$relationships{$id}{type} = $type;
	}
}

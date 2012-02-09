#!/usr/bin/perl
use 5.010_000;
use strict;
use warnings;
use File::Slurp;

my @names_file = read_file($ARGV[0]);
my @relationships_file = read_file($ARGV[1]);

my %names;
my %relationships;

my %relationship_colours = (Lover => 'forestgreen',
                            Ally => 'green',
                            Confidant => 'lime',
                            Friend => 'olive',
                            Acquaintance => 'orange',
                            Rival => 'orangered',
                            Foe => 'firebrick',
                            Enemy => 'red',
                            Archnemesis => 'darkred');

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

print "digraph Relationships {\n";

for my $relid (keys %relationships) {
	my $alias1 = $relationships{$relid}{alias1};
	my $alias2 = $relationships{$relid}{alias2};
	my $name1 = $names{$alias1}{name};
	my $name2 = $names{$alias2}{name};
	my $type = $relationships{$relid}{type};
	my $level = $relationships{$relid}{level};
	my $colour = $relationship_colours{$level};
	my $url = "http://www.uesp.net/wiki/Skyrim:";

	print "$alias1 [label=\"$name1\" URL=\"$url$name1\"];\n";
	print "$alias2 [label=\"$name2\" URL=\"$url$name2\"];\n";

	my $edge = "[label=\"$type\" color=\"$colour\" edgetooltip=\"$name1 -> $name2 ($type, $level)\"]";
	$edge = "[color=\"$colour\" edgetooltip=\"$name1 -> $name2 ($level)\"]" if ($type ~~ "NONE");

	say "$alias1 -> $alias2 $edge;\n";
}

print "}\n";

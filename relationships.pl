#!/usr/bin/perl
use 5.010_000;
use strict;
use warnings;
use File::Slurp;
use Digest::MD5 qw(md5_hex);
use URI::Escape;

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

my %node_printed;
print "digraph Relationships {\n";

for my $relid (keys %relationships) {
	my $alias1 = $relationships{$relid}{alias1};
	my $alias2 = $relationships{$relid}{alias2};
	my $name1 = $names{$alias1}{name};
	my $name2 = $names{$alias2}{name};
	my $image1 = get_image($name1);
	my $image2 = get_image($name2);
	my $type = $relationships{$relid}{type};
	my $level = $relationships{$relid}{level};
	my $colour = $relationship_colours{$level};
	my $url = "http://www.uesp.net/wiki/Skyrim:";

	print "$alias1 [shape=none label=<<TABLE BORDER=\"0\"><TR><TD><IMG SRC=\"$image1\"/></TD></TR><TR><TD>$name1</TD></TR></TABLE>> URL=\"$url$name1\"];\n" unless($node_printed{$name1});
	print "$alias2 [shape=none label=<<TABLE BORDER=\"0\"><TR><TD><IMG SRC=\"$image2\"/></TD></TR><TR><TD>$name2</TD></TR></TABLE>> URL=\"$url$name2\"];\n" unless($node_printed{$name2});

	$node_printed{$name1} = 1;
	$node_printed{$name2} = 1;

	my $edge = "[label=\"$type\" color=\"$colour\" edgetooltip=\"$name1 -> $name2 ($type, $level)\"]";
	$edge = "[color=\"$colour\" edgetooltip=\"$name1 -> $name2 ($level)\"]" if ($type ~~ "NONE");

	say "$alias1 -> $alias2 $edge;\n";
}

print "}\n";


sub get_image
{
	my $name = shift;
	my $filename = "SR-npc-$name.jpg";
	$filename =~ s/\s/_/g;
	my $e_filename = uri_escape($filename);
	my $sized_filename = "120px-$filename";
	my $sized_e_filename = "120px-$e_filename";
	return $sized_filename if(-e $sized_filename);

	my $md5 = md5_hex($filename);
	my $url = "http://images.uesp.net/thumb/".substr($md5,0,1)."/".substr($md5,0,2)."/$e_filename/$sized_filename";
	#`wget -nc $url`;
	return $sized_filename if(-e $sized_filename);
	return "dummy.jpg";
}

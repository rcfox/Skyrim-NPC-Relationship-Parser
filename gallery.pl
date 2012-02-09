#!/usr/bin/perl
use 5.010_000;
use strict;
use warnings;

my @images = glob("noname*.svg");

print<<HTML_HEADER;
<html>
    <head>
        <title>
            Skyrim NPC Relationships
        </title>
        <style>
            img { max-width:100%; height: auto; }
        </style>
    </head>
    <body>
        <p>
            Click an image to see the full-sized version. Or, get everything in <a href="relationships.svg">one, searchable image</a>.
        </p>
HTML_HEADER

for(@images) {
	print<<LINK;
        <a href="$_"><img src="$_" alt="$_" /></a>
LINK
}

print<<HTML_FOOTER;
    </body>
</html>
HTML_FOOTER

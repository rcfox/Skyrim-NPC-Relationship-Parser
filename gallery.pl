#!/usr/bin/perl
use 5.010_000;
use strict;
use warnings;

my @images = glob("noname*.svg");

print<<HTML_HEADER;
<!DOCTYPE html>
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
        <h1>Skyrim NPC Relationship Graphs</h1>
        <p>
            Click an image to see the full-sized version. Or, get everything in <a href="relationships.svg">one, searchable image</a>.
        </p>
        <p>
            <a href="https://github.com/rcfox/Skyrim-NPC-Relationship-Parser">Get the code on GitHub!</a>
        </p>
        <div style="float: left;">
            <h2>Affection level colour key</h2>
            <ul>
              <li><span style="color: forestgreen;">Lover</span></li>
              <li><span style="color: green;">Ally</span></li>
              <li><span style="color: lime;">Confidant</span></li>
              <li><span style="color: olive;">Friend</span></li>
              <li><span style="color: orange;">Acquaintance</span></li>
              <li><span style="color: orangered;">Rival</span></li>
              <li><span style="color: firebrick;">Foe</span></li>
              <li><span style="color: red;">Enemy</span></li>
              <li><span style="color: darkred;">Archnemesis</span></li>
            </ul>
        </div>
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

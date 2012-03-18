#!/usr/bin/perl
use 5.010_000;
use strict;
use warnings;
use File::Slurp qw(slurp);

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
			Click an image or name to go to that character's page on the <a href="http://www.uesp.net/">Unofficial Elder Scrolls Pages Wiki</a>. This is also available as <a href="relationships.svg">one, large image</a>.
		</p>
		<p>Your browser's "find" feature should also work to find characters. Some browsers (Chrome) will get you in the right area, but you generally have to scroll up for some reason.</p>
		<p>All character images come from the characters' respective page on the <a href="http://www.uesp.net/">UESPWiki</a>.</p>
		<p>Note: If a character's image is black, that means there was no standard-sized image availabe. If the image is white, then it didn't render correctly, and I don't know why...</p>
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
	print slurp($_);
}

print<<HTML_FOOTER;
	</body>
</html>
HTML_FOOTER

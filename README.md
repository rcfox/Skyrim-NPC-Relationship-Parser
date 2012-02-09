# I Just Want To See It!

[Go here](http://rcfox.ca/Skyrim-NPC-Relationship-Parser/)

# How Do I Use This?

Just type: make

Or, try: ./relationships.pl names.txt relationships.txt | dot -Tsvg > relationships.svg

## Requirements

* Perl 5.10+
* File::Slurp
* Graphviz

## How To Harvest Your Own Data

In the Skyrim Creation Kit:

* Names:
  * File -> Export -> Names
* Relationships:
  * Character -> Export Relationship Data

(You might need to convert to Unix line endings. I did.)

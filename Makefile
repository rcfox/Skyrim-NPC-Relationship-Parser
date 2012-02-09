all: big
	./relationships.pl names.txt relationships.txt | ccomps -x | dot -Tsvg -O
	./gallery.pl > index.html

big:
	./relationships.pl names.txt relationships.txt | dot -Tsvg > relationships.svg

clean:
	rm -f *.svg
	rm -f *.html

all:
	./relationships.pl names.txt relationships.txt | dot -Tsvg > relationships.svg

clean:
	rm -f *.svg

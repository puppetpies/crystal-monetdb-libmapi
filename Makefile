all: quick

quick:
	crystal build quick.cr -o quick

clean:
	rm -f quick
	rm -Rf .crystal

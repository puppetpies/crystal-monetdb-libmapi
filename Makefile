all: quick

quick:
	crystal build --release quick.cr -o bin/quick

clean:
	rm -f quick
	rm -Rf .crystal

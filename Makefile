all: quick

quick:
	crystal build --release quick.cr -o quick

clean:
	rm -f quick
	rm -Rf .crystal

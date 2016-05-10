all: quick

quick:
	crystal build quick.cr -o bin/quick

quick-release:
	crystal build --release quick.cr -o bin/quick

clean:
	rm -f quick
	rm -Rf .crystal

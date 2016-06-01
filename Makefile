all: quick-release insperf

insperf:
	crystal build --release insperf.cr -o bin/insperf

quick:
	crystal build quick.cr -o bin/quick

quick-release:
	crystal build --release quick.cr -o bin/quick

clean:
	rm -f quick
	rm -Rf .crystal

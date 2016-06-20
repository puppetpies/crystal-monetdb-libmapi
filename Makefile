all: quick-release insperf

insperf:
	crystal compile --release insperf.cr -o bin/insperf

insperf_fiber:
	crystal compile --verbose --threads 16 --release insperf_fiber.cr -o bin/insperf_fiber

quick:
	crystal compile quick.cr -o bin/quick

quick-release:
	crystal compile --release quick.cr -o bin/quick

clean:
	rm -f quick
	rm -Rf .crystal

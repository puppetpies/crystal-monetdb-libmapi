all: quick-release insperf

insperf:
	crystal build --release insperf.cr -o bin/insperf

insperf_fiber:
	crystal build --release insperf_fiber.cr -o bin/insperf_fiber

quick:
	crystal build quick.cr -o bin/quick

quick-release:
	crystal build --release quick.cr -o bin/quick

clean:
	rm -f quick
	rm -Rf .crystal

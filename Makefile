all: quick-release insperf easyconnect

easyconnect:
	crystal build --release easyconnect.cr -o bin/easyconnect

insperf:
	crystal build --release insperf.cr -o bin/insperf

insperf_fiber:
	crystal build --verbose --threads 16 --release insperf_fiber.cr -o bin/insperf_fiber

quick:
	crystal build quick.cr -o bin/quick

quick-release:
	crystal build --release quick.cr -o bin/quick

clean:
	rm -f quick
	rm -Rf .crystal

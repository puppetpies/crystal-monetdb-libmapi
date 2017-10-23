all: quick-release insperf easyconnect

easyconnect:
	crystal build --no-debug --release easyconnect.cr -o bin/easyconnect

insperf:
	crystal build --no-debug --release insperf.cr -o bin/insperf

insperf_fiber:
	crystal build --no-debug --verbose --threads 16 --release insperf_fiber.cr -o bin/insperf_fiber

quick:
	crystal build --no-debug quick.cr -o bin/quick

quick-release:
	crystal build --no-debug --release quick.cr -o bin/quick

clean:
	rm -f quick
	rm -Rf .crystal

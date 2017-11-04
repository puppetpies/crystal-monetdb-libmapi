all: quick-release insperf easyconnect randomize

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

randomize:
	crystal build --no-debug --release randomize.cr -o bin/randomize

# Cleanup all distributed binaries
clean:
	rm -f bin/quick
	rm -f bin/insperf
	rm -f bin/quick-release
	rm -f bin/randomize
	rm -f bin/insperf_fiber
	rm -f bin/easyconnect
	rm -Rf .crystal

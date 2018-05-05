#!/bin/bash

# Used to keep travis from timing out.
keep_alive(){
	while kill -0 $1 > /dev/null 2>&1; do
		echo "$(date) Ping!"
		sleep 300
	done
}

if [ "$#" -eq 0 ]; then
	echo "Building brinkOS"
	cd /build/archlive/ || exit
	./build.sh -v -N brinkOS -o /iso &
	build_pid=$!
	keep_alive $build_pid
	chmod 777 /iso/*.iso
	exit
else
	exec "$@"
fi

#!/usr/bin/bash

qube="alpine-testing-lts"

get_real_time(){
	realtime="$(/usr/bin/time -f "%e" qvm-start -q ${qube})"
	qvm-run "${qube}" qubes-run-terminal
#	qvm-run --pass-io ${qube} -- 'cat /proc/uptime'
	sleep 20
	qvm-shutdown --wait -q "${qube}"
	echo $realtime
}

benchmark() {
	qvm-shutdown --all --wait -q
	for ((i = 0; i < 10; i++)); do
		sleep 15
		echo "$(get_real_time)"
	done
}

benchmark


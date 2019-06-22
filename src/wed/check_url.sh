#!/usr/bin/env bash

function check_url() {
	timeout=5
	fails=0
	success=0

	while true
	do
		wget --timeout=${timeout} --tries=1 http://oldbody.blog.51cto.com -q -o /dev/null

		if [ $? -ne 0 ]; then
		    let fails=fails+1
		else
			 let success=success+1
		fi

		if [ ${success} -ge 1 ]; then
				echo success
				exit 0
		fi

		if [ ${fails} -ge 2 ]; then
			critical="sys is down."
			echo ${critical}|tee|mail -s "$critical" abc@oldboyedu.com
			exit 2
		fi
	done
}

check_url

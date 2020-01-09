#!/usr/bin/env bash

function run() {
	time bash -c "bastille create test$1-$2 12.1-RELEASE 10.1.$1.$2 && bastille start test$1-$2 && bastille cmd test$1-$2 sleep 300; bastille stop test$1-$2 && bastille destroy test$1-$2"
}

function batch() {
	for ((i=1; i < 250; i++)); do
		run $1 $i & sleep 0.1
	done
}

batch 1
batch 2

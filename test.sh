#!/usr/bin/env bash

for ((round=0; round < 5; round++)); do
	for ((i = 0; i < 100; i++)); do
		bash -c "bastille create test$i 12.1-RELEASE 10.0.1.$i && bastille start test$i && bastille cmd test$i sleep 300; bastille stop test$i && bastille destroy test$i" &
	done
done

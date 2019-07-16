#!/usr/bin/env bash

awk '{ print $0 }' /etc/password
echo 'hhh' | awk '{ print "hello, world"}'



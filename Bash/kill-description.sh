#!/bin/bash

# path="/var/log/syslog"
path=$1
kill -9 $(lsof -t $path)
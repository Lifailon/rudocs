#!/bin/bash
path="/var/log/syslog"
kill -9 $(lsof -t $path)
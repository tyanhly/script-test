#!/bin/bash
source ../config.sh
lsof -i tcp:80 | awk 'NR!=1{print $2}' | xargs kill > /dev/null 2>/dev/null


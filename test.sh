#!/bin/bash

#make clean
#make html
#firefox build/html/index.html &
# google-chrome build/html/index.html &

travis-sphinx build --source=./source
firefox doc/build/index.html &

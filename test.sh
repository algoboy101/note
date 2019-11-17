#!/bin/bash

#make clean
#make html
#firefox build/html/index.html &
# google-chrome build/html/index.html &

rm doc -rf
travis-sphinx build --source=./source
#travis-sphinx build --source=./source --nowarn
firefox doc/build/index.html &

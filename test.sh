#!/bin/bash

make clean
make html
firefox build/html/index.html &
# google-chrome build/html/index.html &

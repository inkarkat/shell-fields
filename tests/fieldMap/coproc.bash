#!/bin/bash

load fixture

readonly sedCommand='sed --unbuffered'
readonly uppercaseCommand="$sedCommand -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/"
readonly countCommand="$sedCommand -n ="

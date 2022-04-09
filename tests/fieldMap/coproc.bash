#!/bin/bash

readonly uppercaseCommand='sed --unbuffered -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/'
readonly countCommand='sed --unbuffered -n ='

runStdout() {
  local origFlags="$-"
  set +eET
  local origIFS="$IFS"
  output="$("$@" 2>/dev/null)"
  status="$?"
  IFS=$'\n' lines=($output)
  IFS="$origIFS"
  set "-$origFlags"
}

runStderr() {
  local origFlags="$-"
  set +eET
  local origIFS="$IFS"
  output="$("$@" 2>&1 >/dev/null)"
  status="$?"
  IFS=$'\n' lines=($output)
  IFS="$origIFS"
  set "-$origFlags"
}

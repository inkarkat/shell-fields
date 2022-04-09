#!/bin/bash

readonly sedCommand='sed --unbuffered'
readonly uppercaseCommand="$sedCommand -e y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/"
readonly countCommand="$sedCommand -n ="

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

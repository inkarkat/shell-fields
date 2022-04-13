#!/bin/bash

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

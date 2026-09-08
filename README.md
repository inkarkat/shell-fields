# Shell Fields

_A collection of tools that work with fields and records in text files, like specialized AWK scripts._

![Build Status](https://github.com/inkarkat/shell-fields/actions/workflows/build.yml/badge.svg)

### Dependencies

* Bash, GNU `awk`, GNU `sed`
* [inkarkat/memoizers](https://github.com/inkarkat/memoizers) for the `fieldNormalizeDate` command
* [inkarkat/shell-filters](https://github.com/inkarkat/shell-filters) for literal matching in `fieldGrep`
* [inkarkat/shell-tools](https://github.com/inkarkat/shell-tools) for in-place processing of multiple FILEs by the `eachField` command
* [inkarkat/shell-debugging](https://github.com/inkarkat/shell-debugging) for debugging (optional)
* automated testing is done with _Bats_ - [Bash Automated Testing System](https://github.com/bats-core/bats-core)

### Installation

* The `./bin` subdirectory is supposed to be added to `PATH`.

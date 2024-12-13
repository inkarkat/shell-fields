# Shell Fields

_A collection of tools that work with fields and records in text files, like specialized AWK scripts._

### Dependencies

* Bash, GNU `awk`, GNU `sed`
* [inkarkat/shell-filters](https://github.com/inkarkat/shell-filters) for literal matching in `fieldGrep`
* [inkarkat/shell-tools](https://github.com/inkarkat/shell-tools) for in-place processing of multiple FILEs by the `eachField` command
* automated testing is done with _bats - Bash Automated Testing System_ (https://github.com/bats-core/bats-core)

### Installation

* The `./bin` subdirectory is supposed to be added to `PATH`.

#/usr/bin/env bash

#/ Usage: bash run_tests.sh
#/ Description: Runs unit tests.
#/ Options:
#/   --help: Display this help message
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage


SCRIPT_NAME=$0
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load library
source ${SCRIPT_DIR}/utils.sh

test_check_command() {
	existing_cmd=bash
	non_existing_cmd=somecommandthatisdefinitelynotavailable
	check_command ${existing_cmd}
	assertEquals 0 $?

	check_command ${non_existing_cmd}
	assertEquals 1 $?
}

test_check_null_or_unset() {
	set local some_var
	check_null_or_unset ${some_var}
	assertEquals 1 $?

	some_var=""
	check_null_or_unset ${some_var}
	assertEquals 1 $?

	unset some_var
	check_null_or_unset ${some_var}
	assertEquals 1 $?

	local some_var="A"
	check_null_or_unset ${some_var}
	assertEquals 0 $?

}

test_check_dir() {
	local existing_dir="."
	local existing_file=${SCRIPT_DIR}/${SCRIPT_NAME}
	local non_existing_dir="some/paththatdefinitiely/doesnot/exist"

	check_dir ${existing_dir}
	assertEquals 0 $?

	check_dir ${existing_file}
	assertEquals 1 $?

	check_dir ${non_existing_dir}
	assertEquals 1 $?
}

test_check_file() {
	local existing_file=${SCRIPT_DIR}/${SCRIPT_NAME}
	local existing_dir="."
	local non_existing_file="some/paththatdefinitiely/doesnot/exist"

	check_file ${existing_file}
	assertEquals 0 $?

	check_file ${existing_dir}
	assertEquals 1 $?

	check_file ${non_existing_file}
	assertEquals 1 $?
}

test_set_os_and_ver() {
	unset os
	unset ver
	set_os_and_ver
	check_null_or_unset $os
	assertEquals 0 $?
	check_null_or_unset $ver
	assertEquals 0 $?
	unset os
	unset ver
}

# Load shUnit2
source ${SCRIPT_DIR}/shunit2/shunit2
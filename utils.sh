# Logging helpers, taken from https://dev.to/thiht/shell-scripts-matter
readonly LOG_FILE="/tmp/$(basename "$0").log"
info()    { echo "[INFO]    $*" | tee -a "$LOG_FILE" >&2 ; }
warning() { echo "[WARNING] $*" | tee -a "$LOG_FILE" >&2 ; }
error()   { echo "[ERROR]   $*" | tee -a "$LOG_FILE" >&2 ; }
fatal()   { echo "[FATAL]   $*" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }

# Check if the current user is a root user. Abort otherwise.
check_root() {
	if [[ $EUID -ne 0 ]]; then
   		fatal "This script must be run as root." 
	fi
}

# Check if variable is set and non-empty. Abort otherwise.
# Example: check_null_or_unset ${MY_VAR} "MY_VAR"
check_null_or_unset() {
	local readonly var_val=${1}
	local readonly var_name=${2}
	if [[ -z ${var_val:+x} ]] ; then
		fatal "${var_name} is null or unset."
	fi
}

check_dir() {
	local readonly path=${1}
	local readonly var_name=${2}
	check_null_or_unset ${path} ${var_name}
	if [[ ! -d ${path} ]] ; then
		fatal "${var_name} is not a directory."
	fi
}

check_file() {
	local readonly path=${1}
	local readonly var_name=${2}
	check_null_or_unset ${path} ${var_name}
	if [[ ! -f ${path} ]] ; then
		fatal "${var_name} is not a file."
	fi
}
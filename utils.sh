# Logging helpers, taken from https://dev.to/thiht/shell-scripts-matter
readonly LOG_FILE="/tmp/$(basename "$0").log"
info()    { echo "[INFO]    $*" | tee -a "$LOG_FILE" >&2 ; }
warning() { echo "[WARNING] $*" | tee -a "$LOG_FILE" >&2 ; }
error()   { echo "[ERROR]   $*" | tee -a "$LOG_FILE" >&2 ; }
fatal()   { echo "[FATAL]   $*" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }

# Check if the current user is a root user.
check_root() {
	if [[ $EUID -ne 0 ]]; then
   		fatal "This script must be run as root." 
	fi
}

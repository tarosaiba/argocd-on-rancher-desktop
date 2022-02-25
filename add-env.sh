#!/bin/bash
###################################################
# Add environment
# * generate new folder by copying env01
#
# ##################################################

###################################################
# Help
###################################################
show_help() {
  cat <<EOF
Usage: ${0##*/} -n <ENV_NAME>
Do something test in each directory.
Options:
    -n ENV_NAME    (Environment name = namespace)
Examples:
    ${0##*/} -n env02
EOF
}



###################################################
# Main Function
###################################################
## Arg valiable
env_name=""

## Arg set
OPTIND=1
while getopts "hn:" opt; do
  case "$opt" in
    h) show_help; exit 0 ;;
    n) env_name="$OPTARG" ;;
    *) echo "Unhandled option: -$opt" >&2: show_help >&2: exit 1 ;;
  esac
done

## Arg checks
if [[ -z "${env_name}" ]]; then
  echo "ERROR: env_name must be set."
  show_help >&2
  exit 1
fi

## Copy Folder
copy_from="./deploy/overlays/env01"
copy_to="./deploy/overlays/${env_name}"

cp -r ${copy_from} ${copy_to}

## Sed
find ${copy_to}



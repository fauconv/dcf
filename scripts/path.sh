#!/bin/bash
#+-----------------------------------------------------------+
#|                                                           |
#| pseudo environment for development in DCF                 |
#|                                                           |
#+-----------------------------------------------------------+
#| version : 1                                               |
#+-----------------------------------------------------------+

#DCF paths
SCRIPT_NAME=$(basename $0)
ABS_SCRIPT_PATH=$(dirname `readlink -e $0`);
if [ "$ABS_SCRIPT_PATH" = "" ]; then
  echo "You must be in the directory of the script to call it"
  exit 1
fi

source ${ABS_SCRIPT_PATH}/dcf_path

export PATH=${ABS_SCRIPT_PATH}:${ABS_VENDOR_BIN_PATH}:$PATH

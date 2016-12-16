#!/bin/bash
#+-----------------------------------------------------------+
#|                                                           |
#| pseudo environment for development in DCF                 |
#|                                                           |
#+-----------------------------------------------------------+
#| version : 1                                               |
#+-----------------------------------------------------------+

#DCF paths
SCRIPT_NAME=$(basename "${BASH_SOURCE[0]}")
ABS_SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)
source ${ABS_SCRIPT_PATH}/dcf_path

export PATH=${ABS_SCRIPT_PATH}:${ABS_VENDOR_BIN_PATH}:$PATH

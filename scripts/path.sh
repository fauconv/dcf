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

source ${ABS_SCRIPT_PATH}/dcf/dcf_path

export PATH=${PATH_SCRIPT_PATH}:${PATH_VENDOR_BIN_PATH}:$PATH

cd ${ABS_VENDOR_BIN_PATH}
if [ -f drush ]; then
  for i in drush drush.php drush.launcher
  do
    sed "s|\"\${dir}/${i}\"|\"\${dir}/${i} --alias-path=${ABS_DCF_PATH}/drush/site-aliases\"|" $i > ${i}2
    rm $i
    mv ${i}2 $i
  done
  chmod 770 *
fi

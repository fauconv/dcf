#!/bin/bash
#+----------------------------------------------------------------+
#| Batch to launch cron on all site of the Drupal farm            |
#+----------------------------------------------------------------+
#| version : VERSION_SCRIPT                                       |
#+----------------------------------------------------------------+

#CTM paths
SCRIPT_NAME=$(basename $0)
ABS_SCRIPT_PATH=$(dirname `readlink -e $0`);
if [ "$ABS_SCRIPT_PATH" = "" ]; then
  ABS_SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)
fi
if [ ! -f "${ABS_SCRIPT_PATH}/${SOURCE_PATH}/${SOURCE_SCRIPT}" ]; then
  echo ""
  echo -e "\e[31m\e[1mCTM is not correctly installed\e[0m"
  echo ""
  exit 1
fi
source ${ABS_SCRIPT_PATH}/${SOURCE_PATH}/${SOURCE_SCRIPT}

cd ${ABS_SITES_PATH}

for D in `find "." -type d`
do
  NAME=`echo $D | sed 's|\./||g'`
  if [ "${NAME}" != "default" -a "${NAME}" != "." -a "${NAME}" != ".." -a "${NAME}" != "all" ]; then
    if [ -e ${ABS_CONFIG_PATH}/settings-${NAME}.php ]; then
      ID=`echo $NAME  sed | sed 's|site_||g'`
      ${ABS_SCRIPTS_PATH}/drush @$ID cr
    fi
  fi
done
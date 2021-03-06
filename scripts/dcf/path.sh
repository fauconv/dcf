#!/bin/bash
#+-----------------------------------------------------------+
#|                                                           |
#| all DCF path and constants                                |
#| composer and drush dont like bin dir out of vendor dir    |
#|                                                           |
#+-----------------------------------------------------------+
#| version : VERSION_SCRIPT                                  |
#+-----------------------------------------------------------+

VERSION_SCRIPT="1.0.0"

CONFIG_PATH=config
DOCUMENT_ROOT=web
SITES_PATH=${DOCUMENT_ROOT}/sites #if change update sites.php
DOC_PATH=docs
SCRIPTS_PATH=scripts #if change update project.sh file
VENDOR_PATH=vendor
VENDOR_BIN_PATH=${VENDOR_PATH}/bin
FILES_PATH=files
TRANSLATIONS_PATH=${FILES_PATH}/translations
MEDIAS_PATH=${DOCUMENT_ROOT}/media
DUMP_PATH=dump
SITE_PREFIX=site_

DRUSH_CONFIG=drush
DRUSH_ALIAS=${DRUSH_CONFIG}/site-aliases
DRUSH_PATH=${VENDOR_PATH}/drush/drush

ABS_SCRIPT_PATH=$(realpath $ABS_SCRIPT_PATH)
PATH_SCRIPT_PATH=$ABS_SCRIPT_PATH
if command -v 'cygpath' >/dev/null 2>&1; then
  ABS_SCRIPT_PATH=$(cygpath -m "$ABS_SCRIPT_PATH")
  ABS_SCRIPT_PATH=$(realpath $ABS_SCRIPT_PATH) #yes 2 times
fi
ABS_ROOT_PATH=$(dirname $ABS_SCRIPT_PATH)
PATH_ROOT_PATH=$(dirname $PATH_SCRIPT_PATH)

ABS_CONFIG_PATH=${ABS_ROOT_PATH}/${CONFIG_PATH}
ABS_DOCUMENT_ROOT=${ABS_ROOT_PATH}/${DOCUMENT_ROOT}
ABS_SITES_PATH=${ABS_ROOT_PATH}/${SITES_PATH}
ABS_DOC_PATH=${ABS_ROOT_PATH}/${DOC_PATH}
ABS_DRUSH_PATH=${ABS_ROOT_PATH}/${DRUSH_PATH}
ABS_VENDOR_PATH=${ABS_ROOT_PATH}/${VENDOR_PATH}
ABS_VENDOR_BIN_PATH=${ABS_ROOT_PATH}/${VENDOR_BIN_PATH}
PATH_VENDOR_BIN_PATH=${PATH_ROOT_PATH}/${VENDOR_BIN_PATH}
ABS_SCRIPTS_PATH=${ABS_ROOT_PATH}/${SCRIPTS_PATH}
ABS_DRUSH_CONFIG=${ABS_ROOT_PATH}/${DRUSH_CONFIG}
ABS_DRUSH_ALIAS=${ABS_ROOT_PATH}/${DRUSH_ALIAS}
ABS_MEDIAS_PATH=${ABS_ROOT_PATH}/${MEDIAS_PATH}
ABS_DUMP_PATH=${ABS_ROOT_PATH}/${DUMP_PATH}
ABS_SOURCE_PATH=${ABS_SCRIPTS_PATH}/${SOURCE_PATH}

#
# const
#
ADMIN_NAME=developer

LOCAL_CONF=.config.local.ini
GLOBAL_CONF=.config.global.ini
EXAMPLE=example

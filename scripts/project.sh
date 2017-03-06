#!/bin/bash
#+-----------------------------------------------------------+
#|                                                           |
#| DCF Manager                                               |
#|                                                           |
#| Batch to Manage the entire multi-site/farm/factory/project|
#|                                                           |
#+-----------------------------------------------------------+
#| version : VERSION_SCRIPT                                  |
#+-----------------------------------------------------------+

#DCF paths and init
SOURCE_PATH='dcf'
SOURCE_SCRIPT='dcf_path'
SCRIPT_NAME=$(basename $0)
ABS_SCRIPT_PATH=$(dirname `readlink -e $0`);
if [ "$ABS_SCRIPT_PATH" = "" ]; then
  ABS_SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)
fi
if [ ! -f "${ABS_SCRIPT_PATH}/${SOURCE_PATH}/${SOURCE_SCRIPT}" ]; then
  echo ""
  echo -e "\e[31m\e[1mDCF is not correctly installed\e[0m"
  echo ""
  exit 1
fi
source ${ABS_SCRIPT_PATH}/${SOURCE_PATH}/${SOURCE_SCRIPT}
source ${ABS_SCRIPT_PATH}/${SOURCE_PATH}/dcf_deploy
source ${ABS_SCRIPT_PATH}/${SOURCE_PATH}/dcf_site_deploy
if [ -f ${ABS_SCRIPT_PATH}/${SOURCE_PATH}/env ]; then
  source ${ABS_SCRIPT_PATH}/${SOURCE_PATH}/env
fi
cd ${ABS_ROOT_PATH}

#
# display help
#
function showHelp {
  echo ""
  echo " Drupal Custom Factory Manager Version ${VERSION_SCRIPT}"
  echo ""
  echo " = Usage :"
  echo " ========="
  echo "  commands about the entire farm:"
  echo "  -------------------------------"
  echo ""
  echo "  ${SCRIPT_NAME} deploy (dev | prod) : deploy or update DCF -> get or update DCF composer packages for "
  echo "                                      the project and set project name."
  echo "                                      => need internet access"
  echo "  ${SCRIPT_NAME} fix                 : as \"site fix\" but for the common packages of the project"
  echo "  ${SCRIPT_NAME} unfix               : as \"site unfix\" but for the common packages of the project"
  echo "  ${SCRIPT_NAME} list                : list all web-site (site-id) in this project"
  echo "  ${SCRIPT_NAME} package             : create a package for deployment in production of a project "
  echo "                                       without web-site."
  echo "  ${SCRIPT_NAME} update              : update and rebuild all web-site in production or dev "
  echo "  ${SCRIPT_NAME} set (dev | prod)    : change the environment configuration, and the file right "
  echo "                                      protection"
  echo ""
  echo "  commands about a site of the farm:"
  echo "  ----------------------------------"
  echo ""
  echo "  ${SCRIPT_NAME} site deploy <site_id>   : create or install (if already exist) a web-site in the "
  echo "                                          project for development (create skeleton + install "
  echo "                                          packages(composer, npm, build) + install drupal)"
  echo "                                          => you must set <ID>${LOCAL_CONF} and <ID>${GLOBAL_CONF} before."
  echo "  ${SCRIPT_NAME} site rebuild <site-id>  : compil and build a site for frontend in development"
  echo "  ${SCRIPT_NAME} site fix <site-id>      : Fix packages version (composer and npm) used for this site, "
  echo "                                          usefull for production server, avoid unwanted update of package"
  echo "  ${SCRIPT_NAME} site unfix <site-id>    : Unfix packages version (composer and npm) used for this site, "
  echo "                                          usefull to try update website package in development"
  echo "  ${SCRIPT_NAME} site remove <site-id>   : remove an web-site (installed or not)"
  echo "  ${SCRIPT_NAME} site package <site-id>  : create a package for deployment in production of a specific web-site"
  echo "  ${SCRIPT_NAME} site update <site-id>   : update and rebuild a web-site in production or dev"
  echo "  ${SCRIPT_NAME} site back <site-id>     : site configuration and data go back before the last snapshot or update"
  echo "  ${SCRIPT_NAME} site snapshot <site-id> : make a snapshot (backup) of the site to go back to this point later"
  echo ""
  echo " = More help :"
  echo " ============="
  echo "  Read install.md in \"docs\" directory for more information"
  echo ""
  echo ""
  exit 1
}

#
# display node version
#
function nodeVersion {
  cd ${ABS_ROOT_PATH}
  echo -n "Node version "
  ${SCRIPTS_PATH}/node -v
  echo -n "NPM version "
  ${SCRIPTS_PATH}/npm -v
  composer -V
}

#
#set access right
#
function setRight {
  if [ "$1" = "prod" ]; then
    chmod -R 550 ${ABS_ROOT_PATH}
    for f in ${ABS_MEDIAS_PATH}/*; do
      chmod -R 770 ${f}
    done
  else
    chmod -R 770 ${ABS_ROOT_PATH}
  fi
}

#
# check Composer exist
#
function checkConposer {
  echo "CheckComposer:"
  if [ ! -f "${ABS_SCRIPTS_PATH}/composer.phar" ]; then
    cd ${ABS_SCRIPTS_PATH}
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php composer-setup.php
    rm composer-setup.php
  else
    echo "Composer self install OK"
  fi
}

#
# check php exist and accessible
#
function checkPhp {
  echo "CheckPhp:"
  if command -v php &>/dev/null; then
    echo "PHP detected"
  else
    echo -e "\e[31m\e[1mPHP absent or unreachable\e[0m"
    exit 1
  fi
}

#retrive npm packages
#nodeVersion
#if [ "$1" = "prod" ]; then
  #echo "NPM install (prod) :"
  #${SCRIPTS_PATH}/npm install . --only=prod --nodedir=${SCRIPTS_PATH}/. --prefix=${DOCUMENT_ROOT}
#else
  #echo "NPM install (dev)"
  #${SCRIPTS_PATH}/npm install . --nodedir=${SCRIPTS_PATH}/. --prefix=${DOCUMENT_ROOT}
#fi

#
# main
#
if [ "$1" = "" ]; then
    showHelp
fi
checkPhp
while true; do
  case $1 in
    deploy )
      deploy "$2"
      shift;
      ;;
    site )
      case $2 in
        deploy )
          site_deploy "$3"
          shift;
          ;;
        * )
          echo ""
          echo -e "\e[31m\e[1mUnknown command : $1 $2 !\e[0m"
          showHelp
          ;;
      esac
      shift;
      ;;
    "")
      break
      ;;
    * )
      echo ""
      echo -e "\e[31m\e[1mUnknown command : $1 !\e[0m"
      showHelp
      break
      ;;
  esac
  shift;
done
exit 0

#!/bin/bash
#+-----------------------------------------------------------+
#|                                                           |
#| DCF Manager                                               |
#|                                                           |
#| Batch to Manage the entire multi-site/farm/factory/project|
#|                                                           |
#+-----------------------------------------------------------+
#| version : ${VERSION_SCRIPT}                               |
#+-----------------------------------------------------------+

#
# const
#
VERSION_SCRIPT="0.1.0"
DRUPAL_ANGULAR_URL=https://github.com/fauconv/dcf.git
DRUPAL_ANGULAR_TAG=master

#dcf file names
GLOBAL_CONF=.config.global.ini
LOCAL_CONF=.config.local.ini
EXAMPLE=example

#DCF paths
SCRIPT_NAME=$(basename $0)
ABS_SCRIPT_PATH=`readlink -e $0`;
if [ "$ABS_SCRIPT_PATH" = "" ]; then
ABS_SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)
fi
IS_GET=false
if [ -f "${ABS_SCRIPT_PATH}/dcf_path" ]; then
  source ${ABS_SCRIPT_PATH}/dcf_path
else
  IS_GET=true
fi

#admin user
ADMIN_NAME=developer
SITE_PROFIL=internet

#
# showHelp
#
function showHelp {
  echo ""
  echo "  Drupal Custom Factory Manager Version ${VERSION_SCRIPT}"
  echo ""
  echo "  = Usage :"
  echo "  ========="
  if [ ${IS_GET} = "true" ]; then
    echo "    ${SCRIPT_NAME} get                                            : get DCF (project skeleton) from gitHub."
    echo "                                                                     => need git and internet access"
  else
    echo "    ${SCRIPT_NAME} deploy (dev | prod) <name> [description]        : deploy or update DCF -> get or update DCF composer packages for the project and set project name."
    echo "                                                                     => need internet access"
    echo "    ${SCRIPT_NAME} site deploy (dev | prod) <site_id> [--intranet] : create or install (if already exist) a web-site in the project for development (create skeleton + install packages(composer, npm, build) + install drupal)"
    echo "                                                                     If --intranet is set, intranet profil is used, else internet profil is used."
    echo "    ${SCRIPT_NAME} site rebuild (dev | prod) <site-id>             : compil and build a site for frontend in development"
    echo "    ${SCRIPT_NAME} site fix <site-id>                              : Fix packages version (composer and npm) used for this site, usefull for production server, avoid unwanted update of package"
    echo "    ${SCRIPT_NAME} site unfix <site-id>                            : Unfix packages version (composer and npm) used for this site, usefull to try update website package in development"
    echo "    ${SCRIPT_NAME} fix                                             : as \"site fix\" but for the common packages of the project"
    echo "    ${SCRIPT_NAME} unfix                                           : as \"site unfix\" but for the common packages of the project"
    echo "    ${SCRIPT_NAME} list                                            : list all web-site (site-id) in this project"
    echo "    ${SCRIPT_NAME} site remove <site-id>                           : remove an web-site (installed or not)"
    echo "    ${SCRIPT_NAME} package                                         : create a package for deployment in production of a project without web-site."
    echo "    ${SCRIPT_NAME} site package <site-id>                          : create a package for deployment in production of a specific web-site"
    echo "    ${SCRIPT_NAME} update                                          : update and rebuild all web-site in production or dev "
    echo "    ${SCRIPT_NAME} site update <site-id>                           : update and rebuild a web-site in production or dev"
  fi
  echo ""
  echo "  = More help :"
  echo "  ============="
  echo "  Read install.md in \"docs\" directory for more information"
  echo ""
  echo ""
  exit 1
}

#
# check Git exist
#
function checkGit {
  if ! command -v git >/dev/null 2>&1; then
    echo ""
    echo -e "\e[31m\e[1mGit must be installed and define in the \$PATH variable !\e[0m"
    echo "You can directly get DCF on github: ${DRUPAL_ANGULAR_URL}"
    echo ""
    exit 1
  fi
}

#
# display node version
#
function nodeVersion {
  echo -n "Node version "
  ${ABS_SCRIPTS_PATH}/node -v
  echo -n "NPM version "
  ${ABS_SCRIPTS_PATH}/npm -v
  php ${ABS_SCRIPTS_PATH}/composer.phar -V
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
# check if is windows
# bug fix for cygwin/windows getcwd command
#
validate_os() {
  IS_WINDOW=false
  if [ ! -z $OS ]; then
    WIN=`echo ${OS} | grep -i Windows`
    if [ ! -z $WIN ]; then
      IS_WINDOW=true
    fi
  fi
}

#
# get
#
function get {
  cd $ABS_SCRIPT_PATH
  if [ -d ".git" ]; then
    echo ""
    echo -e "\e[31m\e[1mCan not get DCF from an existing git directory !\e[0m"
    echo ""
    exit 1
  fi
  checkGit
  git clone $DRUPAL_ANGULAR_URL --single-branch --branch $DRUPAL_ANGULAR_TAG clone
  RETURN=$?
  if [ ! $RETURN = 0 ]; then
    echo ""
    echo -e "\e[31m\e[1mInstallation fail, git cannot retrive component !\e[0m"
    exit
  fi
  rm -rf clone/.git
  mv clone/* . 2> /dev/null
  mv clone/.* . 2> /dev/null
  rm -rf clone
  rm ${SCRIPT_NAME}
  chmod 750 scripts/*
  echo ""
  echo "Now use :"
  echo "source scripts/path.sh (optional)"
  echo "${SCRIPT_NAME} deploy dev <project name> [project description]\" to deploy DCF"
  echo ""
}

#
# deploy
# TODO : change part of it in composer plugin
#
function deploy {
  if [ "$2" = "" ]; then
      echo ""
      echo -e "\e[31m\e[1mProject's name missing !\e[0m"
      showHelp;
  fi
  echo "setup project $2..."
  project=$(echo $2 | sed "s| |_|")
  validate_os
  cd ${ABS_DCF_PATH}
  sed "s|^.+\n +\"name\": \".*\"|\"name\": \"${project}\"|" composer.json > composer.json2
  sed "s|\"description\": \".*\"|\"description\": \"$3\"|" composer.json2 > composer.json
  sed "s|\"name\": \".*\"|\"name\": \"${project}\"|" package.json > package.json2
  sed "s|\"description\": \".*\"|\"description\": \"$3\"|" package.json2 > package.json

  #export COMPOSER_HOME=${DCF_HOME}/composer
  #sed "s|\"bin-dir\": \".*\"|\"bin-dir\": \"${DCF_HOME}/${SCRIPTS_PATH}\"|" composer.json > composer.json2
  #sed "s|\"vendor-dir\": \".*\"|\"vendor-dir\": \"${DCF_HOME}/${VENDOR_PATH}\"|" composer.json2 > composer.json
  #sed "s|\"home\": \".*\"|\"home\": \"${COMPOSER_HOME}\"|" composer.json > composer.json2
  #sed "s|\"cache-dir\": \".*\"|\"cache-dir\": \"${COMPOSER_HOME}/cache\"|" composer.json2 > composer.json
  #sed "s|\"data-dir\": \".*\"|\"data-dir\": \"${COMPOSER_HOME}/data\"|" composer.json > composer.json2

  rm composer.json2 package.json2
  chmod 750 ${SCRIPTS_PATH}/*
  checkConposer
  cd ${ABS_DCF_PATH}
  chmod 750 ${SCRIPTS_PATH}/*
  PROD="--no-dev"
  if [ ! "$1" = "prod" ]; then
    PROD=""
  fi
  if [ -f "composer.lock" ]; then
    php ${SCRIPTS_PATH}/composer.phar update $PROD --no-suggest
    RETURN=$?
  else
    php ${SCRIPTS_PATH}/composer.phar install $PROD --no-suggest
    RETURN=$?
  fi
  if [ ! ${RETURN} = 0 ]; then
    exit 1
  fi
  chmod -R 750 ${VENDOR_BIN_PATH}/*
  #if [ ${IS_WINDOW} = true ]; then
    #correct bug of php + cygwin on windows
    #sed "s|return require __DIR__.*|return require __DIR__ . '/../${VENDOR_PATH}/autoload.php';|" ${DOCUMENT_ROOT}/autoload.php > ${DOCUMENT_ROOT}/autoload.php2
    #rm ${DOCUMENT_ROOT}/autoload.php
    #mv ${DOCUMENT_ROOT}/autoload.php2 ${DOCUMENT_ROOT}/autoload.php
  #fi
  #nodeVersion
  #if [ "$1" = "prod" ]; then
    #echo "NPM install (prod) :"
    #${SCRIPTS_PATH}/npm install . --only=prod --nodedir=${SCRIPTS_PATH}/. --prefix=${DOCUMENT_ROOT}
  #else
    #echo "NPM install (dev)"
    #${SCRIPTS_PATH}/npm install . --nodedir=${SCRIPTS_PATH}/. --prefix=${DOCUMENT_ROOT}
  #fi
}

#
# site_deploy
#
function site_deploy {
  if [ $2 = "" ]; then
      echo ""
      echo -e "\e[31m\e[1mSite id missing !\e[0m"
      showHelp;
  fi
  ID=`echo $2 | sed 's|[^a-z]+||g'`
  if [ $ID = "" ]; then
      echo ""
      echo -e "\e[31m\e[1mSite id can only contain lowercase !\e[0m"
      echo ""
      exit 1
  fi
  global_file=${CONFIG_PATH}/${ID}${GLOBAL_CONF}
  local_file=${CONFIG_PATH}/${ID}${LOCAL_CONF}
  yml_file=${CONFIG_PATH}/${ID}${YML_CONF}
  if [ ! -f ${yml_file} ]; then
    if  ! -f ${CONFIG_PATH}/${EXAMPLE}${YML_CONF} ]; then
      echo ""
      echo -e "\e[31m\e[1mFile ${CONFIG_PATH}/${EXAMPLE}${YML_CONF} no longer exist, recreate it from gitHub !\e[0m"
      echo ""
      exit 1
    fi
    cp ${CONFIG_PATH}/${EXAMPLE}${YML_CONF} ${yml_file}
  fi
  if [ ! -f ${global_file} ]; then
    echo ""
    echo -e "\e[31m\e[1mFile ${global_file} is missing\e[0m"
    echo ""
    cp ${CONFIG_PATH}/${EXAMPLE}${GLOBAL_CONF} ${global_file}
    exit 1
  fi
  source ${global}
  if [ $site_name="" ]; then
    echo ""
    echo -e "\e[31m\e[1mFile ${global_file} is empty\e[0m"
    echo ""
    exit 1
  fi
  if [ $3=="--intranet"]; then
    $SITE_PROFIL=intranet
  fi
  ${SCRIPTS_PATH}/drupal init --destination="." -n
  if [! -f ${global_file} ]; then
    ${SCRIPTS_PATH}/drupal chain --file=${yml_file}
  else
    ${SCRIPTS_PATH}/drupal chain --file=${yml_file} --placeholder="db_type: $db_type"
  fi
}

#
# main
#
if [ "$1" = "" ]; then
    showHelp
fi
if [ ${IS_GET} = "true" ]; then
  if [ ! $1 = "get" ]; then
    showHelp
  fi
else
  if [ $1 = "get" ]; then
    echo ""
    echo -e "\e[31m\e[1mGet not allowed in this context\e[0m"
    showHelp
  fi
fi

case $1 in
  deploy )
          deploy "$2" "$3" "$4"
          ;;
  get )
          get
          ;;
  site )
          case $2 in
            deploy )
                  site_deploy "$3" "$4" "$5"
                  ;;
            rebuild )
                  site_rebuild "$3" "$4"
                  ;;
            * )
                  echo ""
                  echo -e "\e[31m\e[1mUnknown command : $1 $2 !\e[0m"
                  showHelp
                  ;;
          esac
          ;;
  * )
          echo ""
          echo -e "\e[31m\e[1mUnknown command : $1 !\e[0m"
          showHelp
          ;;
esac
exit 0

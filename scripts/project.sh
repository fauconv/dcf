#!/bin/bash
#+-----------------------------------------------------------+
#| Batch to Manage the entire multi-site/farm/factory/project|
#+-----------------------------------------------------------+
#| version : ${VERSION_SCRIPT}                               |
#+-----------------------------------------------------------+

#
# const
#
VERSION_SCRIPT="0.1.0"
PHP_VER=5.6.9 #PHP minimum version for drupal
DRUPAL_ANGULAR_URL=https://github.com/fauconv/dcf.git
DRUPAL_ANGULAR_TAG=master
SCRIPT_NAME=$(basename $0)
SCRIPTS_PATH=scripts #depth need to be only 1
CONFIG_PATH=config
CONFIG_CONF=.config.conf
CONFIG_YML=.config.yml
DOCUMENT_ROOT=web

#
# showHelp
#
function showHelp {
  echo ""
  echo "  Drupal Custom Factory Manager Version ${VERSION_SCRIPT}"
  echo ""
  echo "  = Usage :"
  echo "  ========="
  echo "    ${SCRIPT_NAME} create (dev | prod) <project-name> [<project-description>]   : create a multisite drupal project for development. (get the project skeleton from git). \"Create\" command automatically perform \"deploy\" command after creation of the projet"
  echo "    ${SCRIPT_NAME} deploy (dev | prod)                             : get common composer and npm packages for the project. \"site create\" command automatically perform \"site deploy\" command after creation of the projet"
  echo "    ${SCRIPT_NAME} site create (dev | prod) <site_id>              : create a new web-site in the project for development based on the file config/site_id.conf. (create web-site skeleton)"
  echo "    ${SCRIPT_NAME} site deploy (dev | prod) <site-id>              : get specific composer and npm packages for the website"
  echo "    ${SCRIPT_NAME} site install (dev|prod) <site-id>               : install a web-site already created for development or production (drupal install of the web-site)"
  echo "    ${SCRIPT_NAME} site build (dev|prod) <site-id>                 : compil and build a site for frontend in development"
  echo "    ${SCRIPT_NAME} site fix <site-id>                              : Fix the version of packages (composer and npm) used for this site, usefull for production server, avoid unwanted update of package"
  echo "    ${SCRIPT_NAME} site unfix <site-id>                            : Unfix the version of packages (composer and npm) used for this site, usefull to try update website package in development"
  echo "    ${SCRIPT_NAME} fix                                             : as \"site fix\" but for the common packages of the project"
  echo "    ${SCRIPT_NAME} unfix                                           : as \"site unfix\" but for the common packages of the project"
  echo "    ${SCRIPT_NAME} list                                            : list all web-site (site-id) in this project"
  echo "    ${SCRIPT_NAME} package                                         : create a package for deployment in production of a project without web-site."
  echo "    ${SCRIPT_NAME} site package <site-id>                          : create a package for deployment in production of a specific web-site"
  echo "    ${SCRIPT_NAME} update                                          : update the project in production or dev"
  echo "    ${SCRIPT_NAME} site update <site-id>                           : update a site in production or dev"
  echo ""
  echo "  = More help :"
  echo "  ============="
  echo "  Read install.md in \"docs\" directory for more information"
  echo ""
  echo ""
  exit 1
}

#
# checkGit
#
function checkGit {
  if ! command -v git >/dev/null 2>&1; then
    echo ""
    echo ""
    echo "git must be installed and define in the \$PATH variable"
    echo ""
    echo ""
    exit 1
  fi
}

#
# vercomp : return 1 if the first version is newer than the second
#
function vercomp {
  if [[ $1 == $2 ]]
  then
      return 0
  fi
  local IFS=.
  local i ver1=($1) ver2=($2)
  # fill empty fields in ver1 with zeros
  for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
  do
      ver1[i]=0
  done
  for ((i=0; i<${#ver1[@]}; i++))
  do
      if [[ -z ${ver2[i]} ]]
      then
          # fill empty fields in ver2 with zeros
          ver2[i]=0
      fi
      if ((10#${ver1[i]} > 10#${ver2[i]}))
      then
          return 0
      fi
      if ((10#${ver1[i]} < 10#${ver2[i]}))
      then
          return 1
      fi
  done
  return 1
}
function checkPHP {
  if ! command -v php >/dev/null 2>&1; then
    echo ""
    echo ""
    echo "php must be installed and define in the \$PATH variable"
    echo ""
    echo ""
    exit 1
  fi
  phpver=`php -v |grep -Eow '^PHP [^ ]+' |awk '{ print $2 }'`
  echo "Current PHP version : $phpver"
  if  vercomp $PHP_VER $phpver ; then
    echo ""
    echo ""
    echo "php version must be $PHP_VER or better"
    echo ""
    echo ""
    exit 1
  fi
}

#
# checkComposer
#
function checkConposer {
  echo "CheckComposer:"
  if [ ! -f "composer.json" ]; then
    echo ""
    echo ""
    echo "You must create a project first"
    echo ""
    echo ""
    exit 1
  fi
  if [ ! -f "${SCRIPTS_PATH}/composer.phar" ]; then
    cd ${SCRIPTS_PATH}
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php composer-setup.php
    rm composer-setup.php
    cd ..
  fi
}

#
# nodeVersion
#
function nodeVersion {
  echo "Node Version:"
  ${SCRIPTS_PATH}/node -v
  echo "NPM Version:"
  ${SCRIPTS_PATH}/npm -v
}

#
# deploy
#
function deploy {
  checkConposer
  chmod 750 ${SCRIPTS_PATH}/*
  if [ "$1" = "prod" ]; then
    echo "Composer install (prod):"
    php ${SCRIPTS_PATH}/composer.phar install --no-dev --no-suggest -vvv --working-dir=.
  else
    echo "Composer install (dev):"
    php ${SCRIPTS_PATH}/composer.phar install --no-suggest -o
  fi
  chmod -R 750 ${SCRIPTS_PATH}/*
  nodeVersion
  if [ "$1" = "prod" ]; then
    echo "NPM install (prod) :"
    ${SCRIPTS_PATH}/npm install . --only=prod --nodedir=${SCRIPTS_PATH}/. --prefix=${DOCUMENT_ROOT}
    echo "Drupal console init (prod):"
    ${SCRIPTS_PATH}/drupal init --destination=. --override --env="prod" --root="web" --no-interaction
  else
    echo "NPM install (dev)"
    ${SCRIPTS_PATH}/npm install . --nodedir=${SCRIPTS_PATH}/. --prefix=${DOCUMENT_ROOT}
    echo "Drupal console init (dev):"
    ${SCRIPTS_PATH}/drupal init --destination=. --override --env="dev" --root="web" --no-interaction
  fi

}

#
# create
#
function create {
  if [ "$2" = "" ]; then
      echo ""
      echo ""
      echo "project's name missing"
      showHelp;
  fi
  checkPHP
  if [ ! -f "composer.json" ]; then
    if [ -d ".git" ]; then
      echo ""
      echo ""
      echo "Can not create project from an existing git directory"
      echo ""
      echo ""
      exit 1
    fi
    checkGit
    echo "git clone $DRUPAL_ANGULAR_URL --single-branch --branch $DRUPAL_ANGULAR_TAG"
    git clone $DRUPAL_ANGULAR_URL --single-branch --branch $DRUPAL_ANGULAR_TAG clone
    rm -rf clone/.git
    mv clone/* . 2> /dev/null
    mv clone/.* . 2> /dev/null
    rm -rf clone
  fi
  echo "setup project $2..."
  project=$(echo $2 | sed "s| |_|")
  sed "s|\"name\" *: *\".*\"|\"name\": \"${project}\"|" composer.json > composer.json2
  sed "s|\"name\" *: *\".*\"|\"name\": \"${project}\"|" package.json > package.json2
  sed "s|\"description\" *: *\".*\"|\"description\": \"$3\"|" composer.json2 > composer.json
  sed "s|\"description\" *: *\".*\"|\"description\": \"$3\"|" package.json2 > package.json
  rm composer.json2 package.json2
  rm ${SCRIPT_NAME}
  chmod 750 ${SCRIPTS_PATH}/*
  deploy $1
}

#
# site_create
#
function site_create {
  if [ $2 = "" ]; then
      echo ""
      echo ""
      echo "Site id missing"
      showHelp;   
  fi
  ID=`echo $2 | sed 's|[^a-z]+||g'`
  if [ $ID = "" ]; then
      echo ""
      echo ""
      echo "site id can only contain lowercase a-z"
      echo ""
      echo ""
  fi 
  conf_file=${CONFIG_PATH}/${ID}${CONF_EXT}
  yml_file=${CONFIG_PATH}/${ID}${YML_EXT}
  if [ ! -f ${config_file} ]; then
    echo ""
    echo ""
    echo "file ${config_file} does not exist"
    echo ""
    echo ""
    exit 1
  fi
  ${SCRIPTS_PATH}/drupal chain --file=${config_yml}
}

#
# main
#
cd $(dirname $0)
if [ "$1" = "" ]; then
    showHelp;
fi
if [ ! "$1" = "create" ]; then
    cd ..
fi

case $1 in
  create )
          create "$2" "$3" "$4"
          ;;
  deploy )
          deploy "$2"
          ;;
  site )
          case $2 in
            create )
                  site_create "$3" "$4"
                  ;;
            deploy )
                  site_deploy "$3" "$4"
                  ;;
            install )
                  site_install "$3" "$4"
                  ;;
            * )
                  echo "unknown command : $1"
                  showHelp
                  ;;
          esac
          ;;
  * )
          echo "unknown command : $1"
          showHelp
          ;;
esac
exit 0

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
DCF_STABILITY=dev
DCF_AUTHOR=fauconv
DCF_REPO=dcf
DCF_NAME=${DCF_AUTHOR}/${DCF_REPO}
DCF_URL=https://github.com/$DCF_NAME
DCF_TAG=master
DCF_URL_GIT=${DCF_URL}.git
DCF_URL_DOWNLOAD=${DCF_URL}/tarball/${DCF_TAG}


#dcf file names
LOCAL_CONF=.config.local.ini
GLOBAL_CONF=.config.global.ini
EXAMPLE=example

#DCF paths
SCRIPT_NAME=$(basename $0)
ABS_SCRIPT_PATH=$(dirname `readlink -e $0`);
if [ "$ABS_SCRIPT_PATH" = "" ]; then
  ABS_SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)
fi
IS_GET=false
chmod 750 .
if [ -f "${ABS_SCRIPT_PATH}/dcf/dcf_path" ]; then
  source ${ABS_SCRIPT_PATH}/dcf/dcf_path
else
  SCRIPTS_PATH=scripts #depth need to be only 1
  IS_GET=true
  ABS_DCF_PATH=$ABS_SCRIPT_PATH
  ABS_SCRIPTS_PATH=${ABS_SCRIPT_PATH}/$SCRIPTS_PATH
  if [ ! -d ${ABS_SCRIPTS_PATH} ]; then
    mkdir ${ABS_SCRIPTS_PATH}
  fi
  chmod 750 ${ABS_SCRIPTS_PATH}
fi
cd ${ABS_DCF_PATH}

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
  echo "    ${SCRIPT_NAME} deploy (dev | prod) <name> [description]        : deploy or update DCF -> get or update DCF composer packages for the project and set project name."
  echo "                                                                     => need internet access"
  if [ "${IS_GET}" = "false" ]; then
    echo "    ${SCRIPT_NAME} site deploy <site_id>                           : create or install (if already exist) a web-site in the project for development (create skeleton + install packages(composer, npm, build) + install drupal)"
    echo "                                                                     => you must set <ID>${LOCAL_CONF} and <ID>${GLOBAL_CONF} before."
    echo "    ${SCRIPT_NAME} site rebuild <site-id>                          : compil and build a site for frontend in development"
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
# display node version
#
function nodeVersion {
  cd ${ABS_DCF_PATH}
  echo -n "Node version "
  ${SCRIPTS_PATH}/node -v
  echo -n "NPM version "
  ${SCRIPTS_PATH}/npm -v
  ${ABS_SCRIPTS_PATH}/composer -V
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
# deploy
#
function deploy {
  
  #check parameters
  if [ "${2}" = "" ]; then
      echo ""
      echo -e "\e[31m\e[1mProject's name missing !\e[0m"
      showHelp;
  fi
  if [ "${1}" = "dev" ]; then
    PROD=""
    DEV="--dev"
  else 
    if [ "${1}" = "prod" ]; then
      PROD="--no-dev"
      DEV=""
    else 
      echo ""
      echo -e "parameter 2 must be 'dev' or 'prod'. $1 given"
      showHelp;
    fi
  fi
  project=$(echo $2 | sed "s| |_|")
  
  #checkcomposer
  checkConposer
  
  #retrive DCF
  if [ "${IS_GET}" = "true" ]; then
    echo "retrive DCF..."
    cd ${ABS_DCF_PATH}
    ${ABS_SCRIPTS_PATH}/composer create-project ${DCF_NAME} -n --repository '{"type":"vcs", "url":"${DCF_URL}"}' -s $DCF_STABILITY
    if [ ! $? = 0 ]; then
      exit 1
    fi
    source scripts/dcf/dcf_path
    chmod -R 750 ${CONFIG_PATH}
    chmod -R 550 ${DOC_PATH}
    chmod -R 750 ${DOCUMENT_ROOT}
    chmod -R 750 ${SCRIPTS_PATH}
  fi
  
  #setup project
  echo "setup project $2..."
  cd ${ABS_DOCUMENT_ROOT}
  sed "s|^.+\n +\"name\": \".*/.*\"|\"name\": \"${project}\"|" composer.json > composer.json2
  sed "s|\"description\": \".*\"|\"description\": \"$3\"|" composer.json2 > composer.json
  sed "s|\"name\": \".*\"|\"name\": \"${project}\"|" package.json > package.json2
  sed "s|\"description\": \".*\"|\"description\": \"$3\"|" package.json2 > package.json
  rm composer.json2 package.json2
  
 #retrive composer packages
  cd ${ABS_DOCUMENT_ROOT}
  if [ -f "composer.lock" ]; then
    ${ABS_SCRIPTS_PATH}/composer update $PROD --no-suggest
    RETURN=$?
  else
    ${ABS_SCRIPTS_PATH}/composer install $PROD --no-suggest
    RETURN=$?
  fi
  if [ ! ${RETURN} = 0 ]; then
    exit 1
  fi
  
  #retrive npm packages
  #nodeVersion
  #if [ "$1" = "prod" ]; then
    #echo "NPM install (prod) :"
    #${SCRIPTS_PATH}/npm install . --only=prod --nodedir=${SCRIPTS_PATH}/. --prefix=${DOCUMENT_ROOT}
  #else
    #echo "NPM install (dev)"
    #${SCRIPTS_PATH}/npm install . --nodedir=${SCRIPTS_PATH}/. --prefix=${DOCUMENT_ROOT}
  #fi

  #update drush file => must be done by a composer plugin
  cd ${ABS_VENDOR_BIN_PATH}
  if [ -f drush ]; then
    chmod 750 *
    for i in drush drush.php drush.launcher
    do
      sed "s|\"\${dir}/${i}\" \"|\"\${dir}/${i}\" --alias-path=${ABS_DRUSH_ALIAS} \"|" $i > ${i}2
      rm $i
      mv ${i}2 $i
    done
  fi
  
  #update htaccess file => must be done by a composer plugin
  cd ${ABS_DOCUMENT_ROOT}
  TEXT="#-----------------DCF CHANGE TO ORIGINAL DRUPAL .HTACCESS ------------------\n"
  TEXT=${TEXT}"#----------------- To manage multi site wit aliases ------------------------\n"
  TEXT=${TEXT}"RewriteCond %{REQUEST_FILENAME} -f [OR]\n"
  TEXT=${TEXT}"RewriteCond %{REQUEST_FILENAME} -d [OR]\n"
  TEXT=${TEXT}"RewriteCond %{REQUEST_URI} =/favicon.ico\n"
  TEXT=${TEXT}"RewriteRule ^ - [L]\n"
  TEXT=${TEXT}"#Do not remove below tag\n"
  TEXT=${TEXT}"#DCF_MANAGER_TAG\n"
  TEXT=${TEXT}"RewriteRule ^ index.php [L]\n"
  TEXT=${TEXT}"#----------------------------- END DCF CHANGE  -----------------------------\n"
  grep -v "RewriteCond %{REQUEST_FILENAME} " .htaccess > .htaccess2
  grep -v "favicon.ico" .htaccess2 > .htaccess
  OLD="^.* index.php \[.*$"
  sed "s|${OLD}|${TEXT}|" .htaccess > .htaccess2
  rm .htaccess
  mv .htaccess2 .htaccess
  
  #update index.php => must be done by a composer plugin
  sed "s|prod|$1|" index.php > index.php2
  rm index.php
  mv index.php2 index.php
  
  #message
  example_local=${ABS_CONFIG_PATH}/${EXAMPLE}${LOCAL_CONF}
  example2_local=${ABS_CONFIG_PATH}"/<site_id>"${LOCAL_CONF}
  example_global=${ABS_CONFIG_PATH}/${EXAMPLE}${GLOBAL_CONF}
  example2_global=${ABS_CONFIG_PATH}"/<site_id>"${GLOBAL_CONF}
  echo ""
  echo "Now you can create a site:"
  echo " - Copy ${example_local} into"
  echo "        ${example2_local}"
  echo "   and fill it with your information"
  echo " - Copy ${example_global} into"
  echo "        ${example2_global}"
  echo "   and fill it with your information"
  echo " - Then install your site by calling"
  echo "   ${ABS_SCRIPTS_PATH}/${SCRIPT_NAME} site deploy <site-id>"
  echo ""
  echo "Or install an existing one (mean that ${example2_global} already exist):"
  echo " - Copy ${example_local} into"
  echo "        ${example2_local}"
  echo "   and fill it with your information"
  echo " - Then install your site by calling"
  echo "   ${ABS_SCRIPTS_PATH}/${SCRIPT_NAME} site deploy <site-id>"
  echo ""
  echo "Optionnaly you can call:"
  echo "source ${SCRIPTS_PATH}/path.sh"
  echo ""
}

#
# main
#
if [ "$1" = "" ]; then
    showHelp
fi
if [ "${IS_GET}" = "true" ]; then
  if [ ! $1 = "deploy" ]; then
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
                  source ${ABS_SCRIPT_PATH}/dcf/dcf_site_deploy
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

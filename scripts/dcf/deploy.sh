#!/bin/bash
#+-----------------------------------------------------------+
#|                                                           |
#| code for the      deploy command                          |
#|                                                           |
#+-----------------------------------------------------------+
#| version : 1                                               |
#+-----------------------------------------------------------+

#
# deploy
#
function deploy {

  #check parameters
  if [ "${1}" = "dev" ]; then
    PROD=""
    DEV="--dev"
    ENV="dev"
  else
    if [ "${1}" = "prod" ]; then
      PROD="--no-dev"
      DEV=""
      ENV="prod"
    else
      echo ""
      echo -e "parameter 2 must be 'dev' or 'prod'. $1 given"
      showHelp;
    fi
  fi
  echo "ENV=${ENV}" > ${ABS_SCRIPT_PATH}/${SOURCE_PATH}/env

  #set right
  setRight dev;

  #checkcomposer
  checkConposer

  #update DCF
  cd ${ABS_ROOT_PATH}
  if [ -f "composer.lock" ]; then
    php ${ABS_SCRIPTS_PATH}/composer.phar update $PROD --no-suggest -n
    RETURN=$?
  else
    php ${ABS_SCRIPTS_PATH}/composer.phar install $PROD --no-suggest -n
    RETURN=$?
  fi
  if [ ! ${RETURN} = 0 ]; then
    exit 1
  fi

  #update htaccess file
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

  setIndex $1

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

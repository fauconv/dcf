
#
#list task
#
function list {
  echo ""
    echo "= Not installed sites :"
    echo "======================="
    cd ${ABS_SITES_PATH}
    for D in `find . -maxdepth 1 -type d`
    do
      NAME=`echo $D | sed 's|\./||g'`
      if [ "${NAME}" != "default" -a "${NAME}" != "." -a "${NAME}" != ".." -a "${NAME}" != "all" ]; then
        if [ ! -e "${ABS_CONFIG_PATH}/settings-${NAME}.php" ]; then
        echo -n " - ${NAME}"
        if [ -e ${ABS_CONFIG_PATH}/${NAME}${LOCAL_CONF} ]; then
          echo -n " (Local config file present)"
        fi
        if [ -e ${ABS_CONFIG_PATH}/${NAME}${GLOBAL_CONF} ]; then
          echo ""
          else
          echo -e "\e[31m\e[1m (Global config file absent)\e[0m"
          fi
        fi
      fi
    done
    echo ""
    echo "= Live sites :"
    echo "=============="
    for D in `find . -maxdepth 1 -type d`
    do
      NAME=`echo $D | sed 's|\./||g'`
      if [ "${NAME}" != "default" -a "${NAME}" != "." -a "${NAME}" != ".." -a "${NAME}" != "all" ]; then
        if [ -e "${ABS_CONFIG_PATH}/settings-${NAME}.php" ]; then
        echo " - ${NAME}"
          fi
        fi
    done
}

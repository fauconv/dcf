
#
# remove existing file
#
function site_remove {
  if [ -e ${ABS_CONFIG_PATH}/settings-${iD}.php ]; then
    setRight dev
    rm ${ABS_CONFIG_PATH}/settings-${ID}.php ${ABS_CONFIG_PATH}/mock-${ID}.xml ${ABS_CONFIG_PATH}/masquerade-${ID}.xml
    echo -e "Removing ${ID}...                                \e[32m\e[1m[ok]\e[0m"
  fi
}

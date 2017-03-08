
#
#
#
function dump {
    echo -e "dumping database...";
  if [ ! -d $ABS_DUMP_PATH ]; then
      chmod +w $ABS_ROOT_PATH
      mkdir $ABS_DUMP_PATH
    fi
    file=`date +%y%m%d_%H%M%S`
  ${ABS_SCRIPTS_PATH}/drush @$ID sql-dump > ${ABS_DUMP_PATH}/${ID}_${file}.sql
    echo -e "dumping database...                                \e[32m\e[1m[ok]\e[0m";
}

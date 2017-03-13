
#
#
#
function back {
  echo -e "go back to previous snapshot...";
  if [ "$1"="" ];then
    if [ ! -d $ABS_DUMP_PATH ]; then
      echo -e "\e[31m\e[1mNo dump file !\e[0m"
      exit 1
    fi
    cd $ABS_DUMP_PATH
    for D in `find . -maxdepth 1 -type f `
    do
      file=${ABS_DUMP_PATH}/$D
    done
  else
    file=${ABS_DUMP_PATH}/$1
    if [! -f $file ]; then
      echo -e "\e[31m\e[1mFile (${file}) does not exist !\e[0m"
      exit 1
    fi
  fi
  ${ABS_SCRIPTS_PATH}/drush @$ID sql-connect < ${file}
  echo -e "go back to previous snapshot...                                \e[32m\e[1m[ok]\e[0m";
}

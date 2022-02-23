#!/bin/bash
run() {
  while true
  do
    (cd /plexanisync && python PlexAniSync.py)
    sleep ${INTERVAL}
  done
}

####
# Main body of script
###
echo ${SETTINGS_FILE}

#if [ ! -f /config/settings.ini ]; then
#  echo "Updating settings.ini"
  #python /plexanisync/settingsupdater.py
#  run
#else
#  echo "Using custom config: "${SETTINGS_FILE}
#  run
#fi

if [[ -z ${SETTINGS_FILE} ]]; then
  echo "Updating settings.ini"
  python /plexanisync/settingsupdater.py
  run
else
  echo "Using custom config: "${SETTINGS_FILE}
  run
fi
#!/bin/bash

git pull

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

echo 'Rotate log file...'
  "$DIR/rotate.sh"
echo 'Rotated log file!'

echo 'Update config file...'
  sudo cp "$DIR/nginx.conf" /etc/nginx/nginx.conf
  # sudo cp "$HOME/redis.conf" /etc/redis/redis.conf
  # sudo cp "$HOME/my.conf" /etc/mysql/my.cnf
echo 'Updateed config file!'

if [ "$1" = "--compile" ]; then
  echo 'Start compile install...'
  cd "$DIR"
  make
  echo 'compile install finished!'
fi

echo 'Start compile install...'
cd "$DIR"
make
echo 'compile install finished!'

echo 'Restart services...'
  sudo systemctl restart nginx.service
  # sudo systemctl restart redis.service
  # Save cache
  # sudo systemctl restart mysql.service
  sudo systemctl restart isubata.golang.service
echo 'Restarted!'

#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

echo 'Rotate log file...'
  "$DIR/rotate.sh"
echo 'Rotated log file!'

echo 'Update config file...'
  sudo cp "$DIR/nginx.conf" /etc/nginx/nginx.conf
  # sudo cp "$HOME/redis.conf" /etc/redis/redis.conf
  # sudo cp "$HOME/my.conf" /etc/mysql/my.cnf
echo 'Updateed config file!'

if [ "$1" = "--service" ]; then
  echo 'Update service unit file...'
    # -rw-r--r-- 1 root root 382 Oct 22 17:02 /etc/systemd/system/isubata.golang.service
    sudo cp "$DIR/isubata.golang.service" /etc/systemd/system/isubata.golang.service
    sudo systemctl daemon-reload
  echo 'Updated service unit file!'
fi

if [ "$1" = "--bundle" ]; then
  echo 'Start compile install...'
  cd "$DIR"
  make
  echo 'bundle install finished!'
fi

echo 'Restart services...'
  sudo systemctl restart nginx.service
  # sudo systemctl restart redis.service
  # Save cache
  # sudo systemctl restart mysql.service
  sudo systemctl restart isubata.golang.service
echo 'Restarted!'

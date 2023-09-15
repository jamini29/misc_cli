#!/bin/bash

sonar_location="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/"
sonar_filename="sonar-scanner-cli-5.0.1.3006-linux.zip"

cd /tmp || exit;

echo "-- try to download $sonar_filename"
#wget -q ${sonar_location}${sonar_filename} -P "/tmp/" || { echo "unable to download :("; exit; }
curl -sSO $sonar_location$sonar_filename || { echo "ee unable to download :("; exit; }

dest_dir=`zipinfo -1 $sonar_filename | head -n1 | sed 's:/$::'`
if [ -d "/opt/$dest_dir" ]; then
  sudo rm -rf "/opt/$dest_dir"
fi

echo "-- try to unzip ${sonar_filename} to /opt/$dest_dir"
sudo unzip -qq "/tmp/${sonar_filename}" -d "/opt/" || { echo "ee unable to unzip :("; exit; }

if [ -L "/usr/local/bin/sonar-scanner" ]; then
  sudo rm -f /usr/local/bin/sonar-scanner
fi

echo "-- try to link sonar binary"
sudo ln -s "/opt/$dest_dir/bin/sonar-scanner" /usr/local/bin/ || { echo "ee unable to link :("; exit; }

echo "all done"

/usr/local/bin/sonar-scanner --version


#!/usr/bin/ksh

echo "=== Illumarine Installation Configurator ==="

# Prompt for hostname
print -n "Enter hostname: "
read HOSTNAME

# Prompt for timezone
print -n "Enter timezone (e.g., UTC, US/Pacific): "
read TIMEZONE

# Prompt for target disk
while [[ $OS_INSTALL_DISK_SET == 0 ]]; do
  read -e -p "Disk to install to? (? for help) " -i "$(diskinfo|head -n 2|tail -n 1|awk '{print $2}')" OS_INSTALL_TARGET
  if [[ $OS_INSTALL_TARGET = '?' ]]; do
    diskinfo
    OS_INSTALL_DISK_SET=0
  else
    export OS_INSTALL_TARGET
    OS_INSTALL_DISK_SET=1
    export OS_INSTALL_DISK_SET
done

# Write configuration file
CONFIG_FILE="install.conf"
echo "# Illumarine Installation Configuration" > $CONFIG_FILE
echo "hostname=$HOSTNAME" >> $CONFIG_FILE
echo "timezone=$TIMEZONE" >> $CONFIG_FILE
echo "disk=$OS_INSTALL_TARGET" >> $CONFIG_FILE

echo "Configuration written to $CONFIG_FILE"
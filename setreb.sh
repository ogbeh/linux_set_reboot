#!/bin/bash

# Check if the script is executed with sudo privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script with sudo privileges."
  exit 1
fi

# Define the cron job entry
CRON_JOB="00 03 * * * root shutdown -r"

# Check if the cron job already exists in /etc/crontab
if grep -Fxq "$CRON_JOB" /etc/crontab; then
  echo "Rebooting schedule already exists."
else
  # Add the cron job to /etc/crontab
  echo "$CRON_JOB" >> /etc/crontab
  if [ $? -eq 0 ]; then
    echo "Rebooting schedule set up successfully."
  else
    echo "Error: Unable to set up rebooting schedule."
  fi
fi
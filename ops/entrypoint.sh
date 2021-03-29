#!/bin/sh


aws s3 ls "s3://${BUCKET_FOR_CONFIGURATIONS}/${BUCKET_PATH_TO_CONFIGS}/config.php"
config_exit_code=$?
aws s3 ls "s3://${BUCKET_FOR_CONFIGURATIONS}/${BUCKET_PATH_TO_CONFIGS}/env.php"
env_exit_code=$?

echo "config_exit_code=${config_exit_code}"
echo "env_exit_code=${env_exit_code}"


if [ $config_exit_code -eq 0 ] && [ $env_exit_code -eq 0 ]
then
  echo "Config files exist and will be copy"
  aws s3 cp s3://${BUCKET_FOR_CONFIGURATIONS}/${BUCKET_PATH_TO_CONFIGS}/config.php ${APP_PATH_TO_CONFIGS}
  aws s3 cp s3://${BUCKET_FOR_CONFIGURATIONS}/${BUCKET_PATH_TO_CONFIGS}/env.php ${APP_PATH_TO_CONFIGS}
  chown www-data: ${APP_PATH_TO_CONFIGS}/config.php ${APP_PATH_TO_CONFIGS}/env.php
else
  echo "The script failed" >&2
fi


echo "Starting..."
tail -f /dev/null
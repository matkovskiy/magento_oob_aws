#!/bin/sh


ls $APP_PATH_TO_CONFIGS/config.php
config_exit_code=$?
ls $APP_PATH_TO_CONFIGS/env.php
env_exit_code=$?

echo "config_exit_code=${config_exit_code}"
echo "env_exit_code=${env_exit_code}"


if [ $config_exit_code -eq 0 ] && [ $env_exit_code -eq 0 ]
then
  echo "Uploading configs"
  aws s3 cp $APP_PATH_TO_CONFIGS/config.php s3://$BUCKET_FOR_CONFIGURATIONS/$BUCKET_PATH_TO_CONFIGS/config.php
  aws s3 cp $APP_PATH_TO_CONFIGS/env.php s3://$BUCKET_FOR_CONFIGURATIONS/$BUCKET_PATH_TO_CONFIGS/env.php
else
  echo "The script failed" >&2
fi
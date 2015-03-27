#!/bin/bash


#Set log delivery to S3 have to be replaced by something more robust like Splunk.

ec2InstanceId=$(/opt/aws/bin/ec2-metadata --instance-id | cut -d " " -f 2);

echo "aws s3 sync --sse /var/log/  s3://$1/stack/$2/$3-${ec2InstanceId} > /var/log/hourly-logs-backup.log" > /root/s3_log_delivery.sh

chmod 700 /root/s3_log_delivery.sh
cd /root/
crontab -l > cronfile
echo "30 * * * * /root/s3_log_delivery.sh" >> cronfile
crontab cronfile
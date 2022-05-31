In order to push the backup to S3, you need to install awscli and configure it using the following commands;

sudo apt-get install awscli
aws configure

Create an IAM user from aws console and copy the personal access ID and secret key. You need to give these details when running the aws configure command.

Create an S3 bucket to which the dump needs to be pushed. Replace the S3 bucket name in  place of #s3_bucket_name in script.

SCRIPT:

#!/bin/bash
target_dir=/home/backup/data/bkp_`date +%Y"_"%m"_"%d`
Tk_bkp()
{
mkdir $target_dir
xtrabackup --backup --datadir=/var/lib/mysql/ --target-dir=$target_dir
}

if [ ! -d $target_dir ]
then
Tk_bkp
else
rm -rf $target_dir
Tk_bkp
fi

aws s3 mv --recursive /$target_dir/ s3://s3_bucket_name/


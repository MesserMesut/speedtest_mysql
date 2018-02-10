#!/bin/bash

# speedtest_to_mysql by Johannes Grill
# this script uses speedtest.py from github.com/sivel/speedtest-cli to gather the speed of your inet connection and then writes it to mysql database (external or internal)
# you can then use the data however you want, e.g. make a php script to output the data in readable format on a website
# this script is a frankensteinesque monster made from different scripts that fly around on the internet
# thanks fly out to
# github.com/sivel for speedtest.py
# gist.github.com/Dergonic for the template that made this script work
# reddit.com/user/Cr0nixx for another template that made its way via copypaste to this script
# stackoverflow.com because who the fuck doesnt use stackoverflow all of the time
# my mother

##################################################
############### SQL CONFIGURATION ################
##################################################


# DB connection
db_host=#your database host
db_user=#your database username
db_passwd=#your database password

# DB database and table
db_name=#your database name
db_table=#your database table


##################################################
############## HERE BE DRAGONS THEN ##############
##################################################

# temp file holding output to snip it
user=$USER
if test -z $user; then
  user=$USERNAME
fi
log=/tmp/$user/speedtest-mysql.log

# Local functions
str_extract() {
 pattern=$1
 # Extract
 res=`grep "$pattern" $log | sed "s/$pattern//g"`
 # Drop trailing ...
 res=`echo $res | sed 's/[.][.][.]//g'`
 # Trim
 res=`echo $res | sed 's/^ *//g' | sed 's/ *$//g'`
 echo $res
}

mkdir -p `dirname $log`

# run speedtest
/usr/local/bin/speedtest > $log


# parse the output
from=`str_extract "Testing from "`
from_ip=`echo $from | sed 's/.*(//g' | sed 's/).*//g'`
from=`echo $from | sed 's/ (.*//g'`

server=`str_extract "Hosted by "`
server_ping=`echo $server | sed 's/.*: //g'`
server=`echo $server | sed 's/: .*//g'`
server_dist=`echo $server | sed 's/.*\\[//g' | sed 's/\\].*//g'`
server=`echo $server | sed 's/ \\[.*//g'`

download=`str_extract "Download: "`
upload=`str_extract "Upload: "`
share_url=`str_extract "Share results: "`

# create timestamp for database
timestamp=`date +"%Y-%m-%d %H:%M:%S"`

# Send to MySQL

value1=`echo $server_ping | cut -d" " -f1`
value2=`echo $download | cut -d" " -f1`
value3=`echo $upload | cut -d" " -f1`

sql="INSERT INTO $db_table (timestamp,ping,download,upload,server) VALUES ('$timestamp','$server_ping','$download','$upload','$server');"

echo "$sql" | mysql -u$db_user -p$db_passwd -h$db_host $db_name
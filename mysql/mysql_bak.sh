#!/bin/bash

#数据库连接信息
db_user="123456"		#数据库用户名
db_passwd="123456"	#数据库密码
db_name="ops"		#数据库名称

#进入备份目录将之前的移动到old目录
cd /mnt/backup/bakmysql
echo "you are in bakmysql directory now"
mv ops* /mnt/backup/bakmysqlold
echo "Old databases are moved to bakmysqlold folder"

#备份目录
backup_dir="/mnt/backup/bakmysql"

#时间格式
time=$(date +"%Y-%m-%d")

#mysql 备份的命令，注意空格
mysqldump -u$db_user -p$db_passwd $db_name  > "$backup_dir/$db_name"-"$time.sql"
echo "your database backup successfully completed"

#判断前七天的备份文件是否存在,若存在则删除
SevenDays=$(date -d -7day  +"%Y-%m-%d")
if [ -f /mnt/backup/bakmysqlold/$db_name-$SevenDays.sql ]
then
rm -rf /mnt/backup/bakmysqlold/$db_name-$SevenDays.sql
echo "you have already deleted 7days ago bak sql file "
else
echo "7days ago bak sql file not exist "
echo "bash complete"
fi

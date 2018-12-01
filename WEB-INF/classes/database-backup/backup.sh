#!/bin/bash
#功能说明：本功能用于备份数据库

#数据库用户名
dbuser='rib'
#数据库密码
dbpasswd='rib'
#不进行导出的数据库名,可以定义多个数据库，中间以空格隔开，如：test test1 test2
exclude_dbname='information_schema mysql performance_schema sys'
#备份时间
backtime=`date +%Y%m%d_%H%M%S`
#日志备份路径
logpath='/home/cando/database-backup/logs'
#数据备份路径
datapath='/home/cando/database-backup/data'
#整个数据库中的库列表
alldatabase=$(mysql -u $dbuser -p$dbpasswd -Bse 'show databases')

if [ ! -d $logpath ];
then
    mkdir -p $logpath;
fi

if [ ! -d $datapath ];
then
    mkdir -p $datapath;
fi


#日志记录
echo $(date "+%Y-%m-%d %H:%M:%S") 备份数据库开始 >> ${logpath}/mysqllog.log
#正式备份数据库
for database in $alldatabase; do
    skipdb=-1;
    if [ "$exclude_dbname" != "" ]; then
        for db in $exclude_dbname; do
            if [ "$database" == "$db" ];then
                skipdb=1;
                break;
            fi
        done
    fi
    if [ "$skipdb" == "-1" ]; then
        source=`mysqldump -u ${dbuser} -p${dbpasswd} ${database}> ${datapath}/${database}_${backtime}.sql` 2>> ${logpath}/mysqllog.log;
        #备份成功以下操作
        if [ "$?" == 0 ];then
                cd $datapath
                #为节约硬盘空间，将数据库压缩
                tar zcf ${database}_${backtime}.tar.gz ${database}_${backtime}.sql > /dev/null
                #删除原始文件，只留压缩后文件
                rm -f ${datapath}/${database}_${backtime}.sql
                echo $(date "+%Y-%m-%d %H:%M:%S") 数据库 ${database} 备份成功 >> ${logpath}/mysqllog.log
        else
                #备份失败则进行以下操作
                echo $(date "+%Y-%m-%d %H:%M:%S") 数据库 ${database} 备份失败 >> ${logpath}/mysqllog.log
        fi
    fi
done

#删除超过5天的备份数据（具体保留多少时间，可根据实际情况进行调整）
find $datapath -mtime +5 -name '*.tar.gz' -exec rm -rf {} \;
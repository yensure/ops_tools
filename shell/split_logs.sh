#!/bin/sh

#日志所在目录
nodejs_log_dir="/home/nodejs_logs"
#取今日时间
time=`date -d today +%Y%m%d%H`
#日志最大行数
max_lines=400000
#日志名称
logname=stdout.log

#按照日期和行数分割日志
split_logs(){
    for dir in $(echo ${nodejs_log_dir}/*); do
        echo "chdir $dir"
        cd ${dir}
        echo "splitting..."
        if [ -e ${logname} ]; then
               split -l ${max_lines} --additional-suffix=.log ${logname} ${time}
               echo "gzip..."
               gzip ${time}*.log
               echo "clean old log..."
               echo "" > ${logname}
        fi

    done
}

main(){
    split_logs
}

main
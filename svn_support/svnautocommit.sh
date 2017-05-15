#!/bin/bash

#echo "usage: <script> [svn_user]"

case "$#" in
    1)
        svn_user="$1"
        read -s -p "Enter SVN passwd: " svn_passwd
    ;;
    0)
        read -p "Enter SVN user: " svn_user
        read -s -p "Enter SVN passwd: " svn_passwd
    ;;
esac

svn_workspace='/opt/robot/robotworkspace'
svn_commit_msg="$date - automatic commit"
svn="sudo svn"
svn_flags="--username $svn_user --password $svn_passwd --trust-server-cert --non-interactive"

date=`date +"%F %T"`
formated_date=`date +"%Y_%m_%d_%H_%M_%S"`
#script_path=`dirname $(readlink -f $0)`
script_path="$svn_workspace/svn_support"

log_dir="${script_path}/logs"
log_prefix="autocommit"
log="${log_dir}/$log_prefix-$svn_user-$formated_date.log"
keep_last_logs=10

echo -e "\nAuto commit: $date  ..."

mkdir -p $log_dir
#clean logs
cd $log_dir
log_filter="$log_prefix-*.log"
find . -size 0c -delete -name "$log_filter"
(ls -t $log_filter 2>/dev/null|head -n $keep_last_logs; ls $log_filter 2>/dev/null)|sort|uniq -u|xargs \rm -f
cd ../../.

cd $svn_workspace

stat=`$svn status`
if [[ $stat != '' ]]; then
        # delete?
        delete_files=`echo "$stat" | grep -e "^\(\!\|D\)" | tr -s ' ' | cut -d" " -f2`
        if [[ $delete_files != '' ]]; then
                echo -e "\nDelete: " $delete_files
		for file in $delete_files; do
              # $svn delete --force --keep-local $svn_flags $file >>$log
                $svn delete --force $svn_flags $file >>$log
               done
        fi
       
        # add?
      # add_files=`echo "$stat" | grep -e "^\?" | tr -s ' ' | cut -d" " -f2`
        add_files=`echo "$stat" | grep -e "^\?" | grep -v '\/log\/' | grep -v '\/logs\/' | grep -v '\/cronjob_logs\/' | tr -s ' ' | cut -d" " -f2`
        if [[ $add_files != '' ]]; then
		  echo -e "\nAdd: " $add_files
          for file in $add_files; do
            $svn add --force $svn_flags $file >>$log
          done
        fi
        
	#checkout first (update)
	#$svn cleanup $svn_flags *
	#$svn resolved $svn_flags *
       #$svn update --accept mine-full $svn_flags #>/dev/null 2>>/dev/null
       #$svn resolved -R $svn_flags .

	# commit
	echo -e "\n"
        $svn commit -m "$svn_commit_msg" $svn_flags --non-interactive >>$log

	#delete the log if it's 0 sized	
        if [ ! -s $log ] ; then
  	    \rm -f $log
	else
	    #change log file permissions
            chmod 666 $log
	fi
fi

#!/bin/bash

svn_workspace='/opt/robot/robotworkspace'
svn="sudo svn"
script_path="$svn_workspace/robot_testsuites/experimental/hew/test"

cd $svn_workspace
stat=`$svn status`
if [[ $stat != '' ]]; then

	
    #echo "$stat" 
	#echo "$stat" | grep -e "^\?" 
	#filter lines starting with question mark
    #echo "$stat" | grep -e "^\?" | grep -v '\/log\/' | grep -v '\/logs\/' | grep -v '\/cronjob_logs\/' | tr -s ' ' | cut -d" " -f2
	
	#echo "$stat" | grep -e "^\?" | grep -v '\/log\/' | grep -v '\/logs\/' | grep -v '\/cronjob_logs\/' | tr -s ' ' | cut -d" " -f2
    add_files=`echo "$stat" | grep -e "^\?" | grep -v '\/log\/' | grep -v '\/logs\/' | grep -v '\/cronjob_logs\/' | tr -s ' ' | cut -d" " -f2`
    #add_files=`echo "$stat" | grep -e "^\?" | grep -v '\/log\/' | grep -v '\/logs\/' | grep -v '\/cronjob_logs\/' | tr -s ' ' `
    #add_files=`echo "$stat" | grep -e "^\?" | grep -v '\/log\/' | grep -v '\/logs\/' | grep -v '\/cronjob_logs\/' `
    echo -e $add_files

    #echo "$stat" | grep -e "^\?" | grep -v '\/log\/' | grep -v '\/logs\/' | grep -v '\/cronjob_logs\/' | tr -s ' ' | cut -d" " -f2`
    #echo "$stat" | grep -e "^\?" | tr -s ' ' 
    #echo "$stat" | grep -e "^\?" | tr -s ' ' | cut -d" " -f2`
	
    #add_files=`echo "$stat" | grep -e "^\?" | tr -s ' ' | cut -d" " -f2`
    #echo -e "\nAdd: " $add_files
	
fi

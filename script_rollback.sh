#!/bin/bash

declare -A usersGroups=( [GRP_ADM]=nathan,elis,gael [GRP_VEN]=olivia,jorge,dora [GRP_SEC]=luiz,victor,m>
declare -A groupsFolders=( [GRP_ADM]=adm [GRP_VEN]=ven [GRP_SEC]=sec )

echo "--> Deleting folders <--"

rm -r -f -v /public

for group in "${!groupsFolders[@]}";
do
        rm -r -f -v /${groupsFolders[$group]}
done

echo "--> Deleting users <--"

for group in "${!usersGroups[@]}"; 
do
    for user in $(echo ${usersGroups[$group]} | sed "s/,/ /g")
    do
        userdel -r -f $user
    done
done

echo "--> Deleting users groups <--"

for group in "${!usersGroups[@]}";
do
        groupdel -f $group
done

echo "--> Closing the script <--"

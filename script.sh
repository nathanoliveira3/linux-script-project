#!/bin/bash

declare -A usersGroups=( [GRP_ADM]=nathan,elis,gael [GRP_VEN]=olivia,jorge,dora [GRP_SEC]=luiz,victor,marcos )
declare -A groupsFolders=( [GRP_ADM]=adm [GRP_VEN]=ven [GRP_SEC]=sec )

echo "--> Creating users and groups <--"

for group in "${!usersGroups[@]}"; 
do
        groupadd $group

        for user in $(echo ${usersGroups[$group]}| sed "s/,/ /g")
        do
                useradd $user -m -s /bin/bash -p $(openssl passwd -5 abc123) -G $group
                passwd -e $user
        done
done

echo "--> Creating folders and changing permissions <--"

mkdir /public
chmod -v 777 /public

for group in "${!groupsFolders[@]}";
do
        mkdir /${groupsFolders[$group]}
        chown -R -v root:$group /${groupsFolders[$group]}
        chmod -v 770 /${groupsFolders[$group]}
done

echo "--> Closing the script <--"

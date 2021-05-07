#!/usr/bin/env bash

create_or_add_config(){
    if [[ -f "$user_home_dir/.config/rclone/rclone_myscript.conf" ]];then
        echo 'Конфигурация уже добавлена'
    else

 which rclone
    echo "$var1 существует"

cat >> "$user_home_dir/.config/rclone/rclone.conf" << EOF
[Selectel]
type = swift
user =  "$CONTAINER_USER"
key = "$CONTAINER_USER_PASSWORD"
auth = https://auth.selcdn.ru/v1.0
endpoint_type = public
EOF
    # ls "$user_home_dir/.config/rclone/rclone_myscript.conf"
    touch "$user_home_dir/.config/rclone/rclone_myscript.conf"
    echo "Конфигурация rclone добавлена"
    fi
}

user_home_dir=/home/selectel
# if which rclone; then
if rclone -V 2> /dev/null 1> /dev/null; then
    echo "rclone установлен"

    if [[ $# -eq 4 ]]; then
        CONTAINER_NAME=$1
        CONTAINER_USER=$2
        CONTAINER_USER_PASSWORD=$3
        REG_EXPR=$4
        echo 'Четыре параметра переданы'
        create_or_add_config
        DATE=$(date +'%d-%m-%Y:%T')
    # grep -Ril $REG_EXPR
    # LOG_FILES =
    # echo $LOG_FILES

        for file in $(ls $REG_EXPR)
        do
        echo $file
        # rclone copy $file storage:$CONTAINER_NAME/$DATE
        rclone tree Selectel:$CONTAINER_NAME/$DATE
        done
        echo 'Done.'
    else echo 'Введите четыре параметра'
    fi

else
    echo "rclone не установлен"
fi

#!/bin/bash

start() {
    echo "==========start rap2 begin===========";
    docker-compose -f docker-compose-rap2.yml up -d
    echo "==========start rap2 finish===========";
}

stop() {
    echo "===========stop rap2 begin============";
    docker-compose -f docker-compose-rap2.yml down
    echo "===========stop rap2 finish============";
}

status() {
    docker-compose -f docker-compose-rap2.yml ps  
}

restart() {
    stop;
    start;
}
case "$1" in
    'start')
        start
        ;;
    'stop')
        stop
        ;;
    'status')
        status
        ;;
    'restart')
        restart
        ;;
    *)
    echo "usage: $0 {start|stop|status|restart}"
    exit 1
        ;;
    esac

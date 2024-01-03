#!/bin/bash

source ~/.profile
touch $DWM/barscripts/temp

update() {
  [ ! "$1" ] && return
  bash $DWM/barscripts/packages/$1.sh
  shift 1
  update $*
}

refresh() {
    source $DWM/barscripts/temp
    xsetroot -name "$_cpu$_mem$_date$_vol$_bat"
}

cron() {
  while true; do update cpu;  refresh; sleep 300; done &
  while true; do update vol;  refresh; sleep 20; done &
  while true; do update bat;  refresh; sleep 300; done &
  while true; do update date; refresh; sleep 5;   done &
}

case $1 in
  cron) cron ;;
  update) shift 1; update $*; refresh ;;
  refresh) refresh ;;
esac

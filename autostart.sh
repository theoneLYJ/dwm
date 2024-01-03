#!/bin/bash

source ~/.profile
settings() {
    [ $1 ] && sleep $1
    xset -b &                                   # 关闭蜂鸣器
		feh --randomize --bg-fill ~/Pictures/wallpaper/*.png &
		$HOME/.screenlayout/default.sh
}

daemons() {
    [ $1 ] && sleep $1
    $DWM/barscripts/statusbar.sh cron &   # 开启状态栏定时更新
    fcitx5 &                                  # 开启输入法
		picom &
}

cron() {
    [ $1 ] && sleep $1
    let i=10
    while true; do
        [ $((i % 300)) -eq 0 ] && feh --randomize --bg-fill ~/Pictures/wallpaper/*.png # 每300秒更新壁纸
        sleep 10; let i+=10
    done
}

settings 1 &                                  # 初始化设置项
daemons 3 &                                   # 后台程序项
cron 5 &                                      # 定时任务项

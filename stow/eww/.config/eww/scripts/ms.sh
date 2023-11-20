#!/usr/bin/env bash

## Get data
STATUS="$(playerctl status 2> /dev/null)"
COVER="/tmp/.music_cover.png"
MUSIC_DIR="$HOME/Música"

## Get status
get_status() {
	if [ "$STATUS" == "Playing" ]; then
		echo "󰏤"
	else
		echo "󰐊"
	fi
}

## Get song
get_song() {
	song=$(playerctl metadata title)
	if [ -z "$song" ]; then
		echo "Offline"
	else
		echo "$song"
	fi	
}

## Get artist
get_artist() {
	artist=$(playerctl metadata artist)
	if [ -z "$artist" ]; then
		echo ""
	else
		echo "$artist"
	fi	
}

## Get time
get_time() {
	time=$(playerctl position)
	if [ -z "$time" ]; then
		echo "0"
	else
		echo "$time"
	fi	
}

get_ctime() {
	ctime=$(playerctl metadata mpris:length | awk '{print int($1 / 1000000)}')
	if [ -z "$ctime" ]; then
		echo "0:00"
	else
		echo "$ctime"
	fi	
}

get_ttime() {
	ttime=$(playerctl metadata mpris:length | awk '{printf "%d:%02d", int($1 / 60000000), int(($1 % 60000000) / 1000000)}')
	if [ -z "$ttime" ]; then
		echo "0:00"
	else
		echo "$ttime"
	fi	
}

## Get cover
get_cover() {
	cover=$(playerctl metadata mpris:artUrl | sed 's/file:\/\///')
	if [ -z "$cover" ]; then
		echo "images/music.png"
	else
		ffmpeg -i "$cover" "$COVER" -y &> /dev/null
		echo "$COVER"
	fi
}

## Execute accordingly
if [ "$1" == "--song" ]; then
	get_song
elif [ "$1" == "--artist" ]; then
	get_artist
elif [ "$1" == "--status" ]; then
	get_status
elif [ "$1" == "--time" ]; then
	get_time
elif [ "$1" == "--ctime" ]; then
	get_ctime
elif [ "$1" == "--ttime" ]; then
	get_ttime
elif [ "$1" == "--cover" ]; then
	get_cover
elif [ "$1" == "--toggle" ]; then
	playerctl play-pause
elif [ "$1" == "--next" ]; then
	playerctl next
	get_cover
elif [ "$1" == "--prev" ]; then
	playerctl previous
	get_cover
fi


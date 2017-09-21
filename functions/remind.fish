function remind
	sleep $argv[1]
	notify-send "$argv[2]"
	mpv /usr/share/sounds/ubuntu/stereo/bell.ogg
end

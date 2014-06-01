function hddtest
	set -l du (df $argv[1] | tail -n1 | tr -s ' ' ' ' | cut -d' ' -f 5 | cut -d'%' -f1)
	if test $du -gt 80
	  printf "$fish_color_error argv[1] $du%%"
	end
end

function fish_prompt --description 'the prompt'
	set -l last_status $status
	#printf "\033[K"

	set_color $fish_date_color1
	printf (date +"%H:%M:%S ")
	set_color $fish_date_color2
	printf (date +"%d/%m/%y ")
	set_color normal

	# Show loadavg when too high
	set -l load1m (uptime | grep -o '[0-9]\+\,[0-9]\+' | head -n1)
	set -l load1m_test (math (echo $load1m|sed -s s/,/\./) \* 100 / 1)
	if test $load1m_test -gt 100
	  set_color $fish_color_error; printf "$load1m "
	end

	# Show disk usage when low
	hddtest /
	hddtest /media/gabriel/storage/
	 
	# Virtual Env
	if set -q VIRTUAL_ENV
	set_color $fish_color_comment; printf (basename "$VIRTUAL_ENV")
	set_color normal
	end
	 
	set_color $fish_color_param; __fish_git_prompt; set_color normal
	 
	if [ $last_status -ne 0 ]
		set_color $fish_color_error; printf " $last_status"
		set -ge status
	end

	set_color green; printf " $CMD_DURATION"

	printf "\n"
	set_color $fish_color_user; echo -n (whoami)
	set_color normal; printf '@'
	set_color $fish_color_host; echo -n (hostname -s)
	set_color normal; printf ":"
	set_color $fish_color_cwd; printf (prompt_pwd)

	#printf (pwd | sed "s,/,$c0/$c1,g" | sed "s,\(.*\)/[^m]*m,\1/$c3,")
	 
	printf "> "
end

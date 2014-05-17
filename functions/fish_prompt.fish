function _common_section
	printf $c1
	printf $argv[1]
	printf $c0
	printf ":"
	printf $c2
	printf $argv[2]
	printf $argv[3]
	printf $c0
	printf " "
end
 
function section
	 _common_section $argv[1] $c3 $argv[2] $ce
end
  
function error
	_common_section $argv[1] $ce $argv[2] $ce
end

function hddtest
	set -l du (df $argv[1] | tail -n1 | tr -s ' ' ' ' | cut -d' ' -f 5 | cut -d'%' -f1)
	if test $du -gt 80
	error du "argv[1] $du%%"
	end
end

function fish_prompt
	set -l last_status $status
	set -g c0 (set_color 005284)
	set -g c1 (set_color 0075cd)
	set -g c2 (set_color 009eff)
	set -g c3 (set_color 6dc7ff)
	set -g c4 (set_color ffffff)
	set -g ce (set_color $fish_color_error)

	printf "\033[K"

	set_color F2FF41; printf (date +"%H:%M:%S ")
	set_color CDCDCD; printf (date +"%d/%m/%y ")

	# Show loadavg when too high
	set -l load1m (uptime | grep -o '[0-9]\+\,[0-9]\+' | head -n1)
	set -l load1m_test (math (echo $load1m|sed -s s/,/\./) \* 100 / 1)
	if test $load1m_test -gt 100
	error load $load1m
	end

	# Show disk usage when low
	hddtest /
	hddtest /media/gabriel/stockage
	 
	# Virtual Env
	if set -q VIRTUAL_ENV
	set_color 95D6FF; printf (basename "$VIRTUAL_ENV")
	end
	 
	# Git branch and dirty files
	#git_branch
	#if set -q git_branch
	#set out $git_branch
	#if test $git_dirty_count -gt 0
	#set out "$out$c0:$ce$git_dirty_count"
	#end
	#section git $out
	#end
	#set out $__fish_git_prompt
	git rev-parse --is-inside-work-tree >/dev/null ^/dev/null; and set_color yellow; __fish_git_prompt
	 
	if [ $last_status -ne 0 ]
		printf " "
		error last $last_status
		set -ge status
	end

	set_color green; printf "$CMD_DURATION"

	printf "\n"
	printf $c1
	printf (pwd | sed "s,/,$c0/$c1,g" | sed "s,\(.*\)/[^m]*m,\1/$c3,")
	 
	printf $c4
	printf "~> "
end


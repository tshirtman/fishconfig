function kubectl_status
  [ -z "$KUBECTL_PROMPT_ICON" ]; and set -l KUBECTL_PROMPT_ICON "⎈"
  [ -z "$KUBECTL_PROMPT_SEPARATOR" ]; and set -l KUBECTL_PROMPT_SEPARATOR "/"
  set -l config $KUBECONFIG
  [ -z "$config" ]; and set -l config "$HOME/.kube/config"
  if [ ! -f $config ]
    echo (set_color red)$KUBECTL_PROMPT_ICON" "(set_color white)"no config"
    return
  end

  set -l ctx (kubectl config current-context 2>/dev/null)
  if [ $status -ne 0 ]
    echo (set_color red)$KUBECTL_PROMPT_ICON" "(set_color white)"no context"
    return
  end

  set -l ns (kubectl config view -o "jsonpath={.contexts[?(@.name==\"$ctx\")].context.namespace}")
  [ -z $ns ]; and set -l ns 'default'

  echo (set_color cyan)$KUBECTL_PROMPT_ICON" "(set_color white)"($ctx$KUBECTL_PROMPT_SEPARATOR$ns)"
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
	set -l load1m (uptime | grep -o '[0-9]\+[\.\,][0-9]\+' | head -n1)
	set -l load1m_test (math (echo $load1m|sed -s s/,/\./) \* 100 / 1)
	if test $load1m_test -gt 100
	  set_color $fish_color_error; printf "$load1m"
	end

	printf (kubectl_status)

	# Virtual Env
	if set -q VIRTUAL_ENV
	  set_color green; printf "🐍("; printf (basename "$VIRTUAL_ENV"); printf ")"
	  set_color normal
	end

	set_color $fish_color_param; __fish_git_prompt; set_color normal

	if [ $last_status -ne 0 ]
		set_color $fish_color_error; printf " $last_status"
		set -e status
	end

	set_color green; printf " $CMD_DURATION"
	# if test $CMD_DURATION -a $CMD_DURATION -gt 10000
	# 	set seconds (math $CMD_DURATION / 1000)"s"
	# 	notify-send -t 1 "finished after $seconds" "$history[1]" --urgency low
	# 	set -ge CMD_DURATION
	# end

	printf "\n"
	set_color $fish_color_user; echo -n (whoami)
	set_color normal; printf '@'
	set_color $fish_color_host; echo -n (hostname -s)
	set_color normal; printf ":"
	set_color $fish_color_cwd; printf (prompt_pwd)

	printf "> "
end

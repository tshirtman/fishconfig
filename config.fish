#
# Init file for fish
#

#
# Some things should only be done for login terminals
#

if status --is-login

	#
	# Set some value for LANG if nothing was set before, and this is a
	# login shell.
	#

	if not set -q LANG >/dev/null
		set -gx LANG en_US.UTF-8
	end

	# Check for i18n information in
	# /etc/sysconfig/i18n

	if test -f /etc/sysconfig/i18n
		eval (cat /etc/sysconfig/i18n |sed -ne 's/^\([a-zA-Z]*\)=\(.*\)$/set -gx \1 \2;/p')
	end

	#
	# Put linux consoles in unicode mode.
	#

	if test "$TERM" = linux
		if expr "$LANG" : ".*\.[Uu][Tt][Ff].*" >/dev/null
			if which unicode_start >/dev/null
				unicode_start
			end
		end
	end
end

. ~/.config/fish/virtual.fish
. ~/.config/fish/auto_activation.fish

alias v vim
alias g git
alias l ls
alias b bash
alias p python

setenv EDITOR vim
setenv TERM xterm

set fish_date_color1 93cc93
set fish_date_color2 ccaf93

# Base16 Shell
if status --is-interactive
    if not set -q TMUX
        set BASE16_SHELL "$HOME/.config/base16-shell/"
        source "$BASE16_SHELL/profile_helper.fish"
    end
end

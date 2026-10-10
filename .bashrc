# .bashrc

if [ -f ~/.aliases ]; then
	. ~/.aliases
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/scripts" ]; then
    export PATH="$HOME/scripts:$PATH"
fi

# disable stripe cli telemetry
export STRIPE_CLI_TELEMETRY_OPTOUT=1

if [ "`id -u`" -eq "0" ]; then
   prompt_suffix="#"
else
   prompt_suffix="$"
fi

export PS1="\[$(tput setaf 10)\]\u\[$(tput setaf 35)\]@\[$(tput setaf 38)\]\h \[$(tput setaf 252)\]\w \[$(tput setaf 248)\]$prompt_suffix\[$(tput sgr0)\] "

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

syncstatus() {
    watch -d grep -e Dirty: -e Writeback: /proc/meminfo
}

# Machine-local overrides
if [ -f "$HOME/.bashrc.local" ]; then
    . "$HOME/.bashrc.local"
fi

alias ef="vim ~/.config/fish/config.fish"
alias evb="vim ~/.vim/vimrc/basic.vim"
alias evp="vim ~/.vim/vimrc/plugin.vim"
alias evl="vim ~/.vim/vimrc/lang.vim"

alias ll="ls -l"
alias his='history'
alias less 'less -S -N'

alias tinypng=pngquant
alias dns_cache_clear="sudo killall -HUP mDNSResponder"

export LESS=x2
export SVN_EDITOR="vim"
export HISTSIZE=10000
export XDG_CONFIG_HOME="$HOME/.config"

function fg -d "advanced fg command"
	if test (count $argv) -eq 0
		builtin fg
		return
	end

	set -l PID (jobs | awk '$1 ~ /[0-9]+/{print $2}' | sort -n -k2 )
	set -l COUNT (count $PID)
	if test $COUNT -ge $argv
		builtin fg $PID[$argv]
	else
		jj
	end
end

function jj -d "advanced jobs command"
	for j in (jobs | sort -n -k2 | awk '$1 ~ /[0-9]+/{print sprintf("[%d] %d %s %s", NR, $2, $5, $6)};') ; echo $j; end
end

function fish_user_key_bindings
	for mode in insert default visual
		bind -M $mode \ca beginning-of-line
		bind -M $mode \ce end-of-line
		bind -M $mode \cf forward-char
	end
end 

function hybrid_bindings --description "Vi-style bindings that inherit emacs-style bindings in all modes"
	for mode in default insert visual
		fish_default_key_bindings -M $mode
	end
	fish_vi_key_bindings
end

set -g fish_key_bindings hybrid_bindings

source ~/perl5/perlbrew/etc/perlbrew.fish


function ef
	vim ~/.config/fish/config.fish
end

function evb 
	vim ~/.vim/vimrc/basic.vim
end

function evp
	vim ~/.vim/vimrc/plugin.vim
end

function evd
	vim ~/.vim/vimrc/dein_plugins.toml
end

function evdl
	vim ~/.vim/vimrc/dein_plugins_lazy.toml
end

function evl
	vim ~/.vim/vimrc/lang.vim
end

function ehttpdconf
	sudo vim /etc/httpd/conf/httpd.conf
end

function errlog 
	sudo less -S /var/log/httpd/error_log
end

function fsw 
	find . -name '.*.swp'
end

function calc
	perl -e "print $argv"
end

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


alias lls "ls -altr"
alias grephp "grep -Prin --color --include='*.php'"
alias greptpl "grep -Prin --color --include='*.tpl'"
alias sudo 'sudo -E '
alias tinypng 'pngquant'
alias his 'history'
alias less 'less -S -N'
alias yag "ag --hidden -G '\.(php|tpl)'"
alias gplo "git pull origin"

export SVN_EDITOR=nvim
export BUSHO_ENV=dev
export HISTCONTROL=ignoredups
export HISTSIZE=10000
export LESS=x2
export LESSCHARSET=utf-8
export XDG_CONFIG_HOME="$HOME/.config"

source ~/perl5/perlbrew/etc/perlbrew.fish

if status --is-login
	if test $SSH_TTY
		# fish_logo
	end
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

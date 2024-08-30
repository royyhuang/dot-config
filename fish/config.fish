source {$FISH_CONFIG_DIR}/cc-env.fish
source {$FISH_CONFIG_DIR}/theme.fish
fzf --fish | source

set --local  FISH_CONFIG_DIR (dirname (status -f))

set --export TERM xterm-256color
set --export EDITOR nvim
set --export PATH \
	{$HOME}/.local/bin \
	/bin /sbin \
	/usr/bin /usr/sbin \
	/usr/local/bin /usr/local/sbin

alias vim='nvim'
alias vi='nvim'
alias ls="ls --color=always"
alias cat='highlight -O ansi --force'
alias rm="trash"

# macOS specific setups
if test (uname) = "Darwin"
	source {$FISH_CONFIG_DIR}/config.fish.mac
else
	source {$FISH_CONFIG_DIR}/config.fish.linux
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
    function my_vi_bindings
		fish_vi_key_bindings
		bind -M insert -m default jj backward-char force-repaint
		bind -M insert \cf accept-autosuggestion
		bind \cf accept-autosuggestion
    end
    set -g fish_key_bindings my_vi_bindings
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f {$HOME}/.local/miniconda3/bin/conda
    eval {$HOME}/.local/miniconda3/bin/conda "shell.fish" "hook" {$argv} | source
end
# <<< conda initialize <<<

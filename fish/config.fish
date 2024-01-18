set --export PATH $HOME/.local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin
set --export PYTHONPATH $PYTHONPATH
set --export EDITOR nvim

set --export OS_AUTH_TYPE v3applicationcredential
set --export OS_AUTH_URL https://chi.uc.chameleoncloud.org:5000/v3
set --export OS_IDENTITY_API_VERSION 3
set --export OS_REGION_NAME "CHI@UC"
set --export OS_INTERFACE public
set --export OS_APPLICATION_CREDENTIAL_ID fafda5cf152a47bba5d3876c43adf093
set --export OS_APPLICATION_CREDENTIAL_SECRET jlHTJC9tHp8SMdpYIAxamOlohkp02IZxeHYZMiMmMVXuzFDR__rSLgm-cQcMqqjoz8NK2Gd8p0J-PxZ-FZlFug

set --export GH_TOKEN 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

alias rmswp='rm .*.swp'
alias vim='nvim'
alias vi='nvim'
alias cat='highlight -O ansi --force'
alias extend-lease='blazar lease-update --prolong-for "7d"'
alias ls="ls --color=always"
alias rm="trash"

# Title 
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user yes
set -g theme_title_use_abbreviated_path yes

set -g theme_display_ruby yes
set -g theme_display_virtualenv yes
set -g theme_display_vagrant no
set -g theme_display_vi yes
set -g theme_display_k8s_context no # yes
set -g theme_display_user yes
set -g theme_display_hostname yes
set -g theme_show_exit_status yes
set -g theme_git_worktree_support no
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_master_branch yes
set -g theme_display_date yes
set -g theme_display_cmd_duration yes
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g theme_color_scheme solarized-dark

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
if test -f $HOME/.local/miniconda3/bin/conda
    eval $HOME/.local/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<


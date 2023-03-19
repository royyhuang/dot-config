set PATH $HOME/.local/bin /Library/TeX/texbin $HOME/.emacs.d/bin $HOME/.config/emacs/bin /opt/homebrew/Cellar/openjdk/18.0.1.1/bin /usr/local/opt/llvm/bin /opt/homebrew/bin /opt/homebrew/sbin $HOME/bin /usr/local/sbin /Users/royhuang/Library/Python/3.7/bin /usr/bin /usr/sbin /bin /sbin
set --export PYTHONPATH /Users/royhuang/Documents/ucare/napp-lat /Users/royhuang/Documents/ce/src $PYTHONPATH
set EDITOR vim
set --export JAVA_HOME (/usr/libexec/java_home -v 19)
set --export PACKER_HOME /Users/royhuang/.local/share/nvim/site/pack/packer/start
set --export CS154_ADMIN ~/Documents/uc-cs/cs154-aut-22-admin/

set --export OS_AUTH_TYPE v3applicationcredential
set --export OS_AUTH_URL https://chi.uc.chameleoncloud.org:5000/v3
set --export OS_IDENTITY_API_VERSION 3
set --export OS_REGION_NAME "CHI@UC"
set --export OS_INTERFACE public
set --export OS_APPLICATION_CREDENTIAL_ID fafda5cf152a47bba5d3876c43adf093
set --export OS_APPLICATION_CREDENTIAL_SECRET jlHTJC9tHp8SMdpYIAxamOlohkp02IZxeHYZMiMmMVXuzFDR__rSLgm-cQcMqqjoz8NK2Gd8p0J-PxZ-FZlFug

set --export GH_TOKEN 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

set --export DIRPAPERS $HOME/Documents/ucare/DIR-PAPERS

set --export ICLD_DOC "/Users/royhuang/Library/Mobile Documents/com~apple~CloudDocs/Documents"

set all_proxy
set http_proxy
set https_proxy

alias showfiles="defaults write com.apple.finder AppleShowAllFiles true; killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles false; killall Finder"
alias eclimd="/Applications/Eclipse.app/Contents/Eclipse/eclimd"
alias rmswp='rm .*.swp'
alias vim='nvim'
alias vi='nvim'
alias cat='highlight -O ansi --force'
alias build='docker buildx build --platform linux/arm64 --ssh default --secret id=my_secret,src=$HOME/.ssh/id_rsa.pub -t 1nfinity/ce-dev --load .'
alias extend-lease='blazar lease-update --prolong-for "7d"'
alias ls="ls --color=always"
alias rm="trash"
alias tex-clean="rm -f *.aux *.fdb_latexmk *.fls *.log *.out *.synctex.gz"
alias ta="cd $CS154_ADMIN"
alias pta="cd $HOME/Documents/uc-cs/cs154-aut-21-admin"
alias home="cd $HOME"
alias doc="cd $HOME/Documents"
alias down="cd $HOME/Downloads"

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
if test -f /Users/royhuang/.local/miniconda3/bin/conda
    eval /Users/royhuang/.local/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<


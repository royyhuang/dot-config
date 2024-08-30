set --export TERM xterm-256color
set --export EDITOR nvim

set --export PATH {$HOME}/.local/bin /bin /sbin /usr/bin /usr/sbin \
	/usr/local/bin /usr/local/sbin

# Set up the environment for the CHI@UC cloud
set --export OS_AUTH_TYPE v3applicationcredential
set --export OS_AUTH_URL https://chi.uc.chameleoncloud.org:5000/v3
set --export OS_IDENTITY_API_VERSION 3
set --export OS_REGION_NAME "CHI@UC"
set --export OS_INTERFACE public
set --export OS_APPLICATION_CREDENTIAL_ID fafda5cf152a47bba5d3876c43adf093
set --export OS_APPLICATION_CREDENTIAL_SECRET \
	"jlHTJC9tHp8SMdpYIAxamOlohkp02IZxeHYZMiMmMVXuzFDR__rSLgm-cQcMqqjoz8NK2Gd8"\
	"p0J-PxZ-FZlFug"

set --export ALCHEMISTS_HOME $HOME/alchemists
set --export BENCHMARK_HOME $ALCHEMISTS_HOME/benchmark
set --export PYTHONPATH \
	$ALCHEMISTS_HOME \
	$BENCHMARK_HOME/simple/server \
	$BENCHMARK_HOME/simple/tracer \
	$BENCHMARK_HOME/vllm
set --export PATH $ALCHEMISTS_HOME/benchmark/simple/bin $PATH
set --export VLLM_ATTENTION_BACKEND XFORMERS

alias vim='nvim'
alias vi='nvim'
alias ls="ls --color=always"
alias rm="trash"
alias gserver="cd $ALCHEMISTS_HOME/alchemists/server"
alias gapi="cd $ALCHEMISTS_HOME/alchemists/api"
alias gtracer="cd $ALCHEMISTS_HOME/alchemists/tracer"
alias gslog="cd $ALCHEMISTS_HOME/log/server"
alias gtlog="cd $ALCHEMISTS_HOME/log/tracer"

# macOS specific setups
if test (uname) = "Darwin"
	set --export UCARE {$HOME}/Documents/ucare
	set --export DIRPAPERS {$UCARE}/DIR-PAPERS
	set --export SUBM {$UCARE}/submission
	set --export DOC {$HOME}/Documents
	set --export PATH \
		{$DIRPAPERS}/scripts \
		{$DIRPAPERS}/scripts/common \
		{$HOME}/.config/emacs/bin \
		/Library/TeX/texbin \
		/Users/royhuang/Library/Python/3.9/bin \
		/usr/local/opt/llvm/bin \
		/opt/homebrew/bin \
		/opt/homebrew/sbin \
		/Users/royhuang/Library/Python/3.7/bin \
		{$PATH}
	set --export PYTHONPATH {$UCARE}/napp-lat {$PYTHONPATH}
	set --export JAVA_HOME (/usr/libexec/java_home)
	set --export PACKER_HOME {$HOME}/.local/share/nvim/site/pack/packer/start
	alias home="cd {$HOME}"
	alias doc="cd {$HOME}/Documents"
	alias down="cd {$HOME}/Downloads"
	alias cat='highlight -O ansi --force'
	alias tex-clean="rm -f *.aux *.fdb_latexmk *.fls *.log *.out *.synctex.gz"

	source {$HOME}/.config/fish/az.fish
end


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
if test -f {$HOME}/.local/miniconda3/bin/conda
    eval {$HOME}/.local/miniconda3/bin/conda "shell.fish" "hook" {$argv} | source
end
# <<< conda initialize <<<

set --export fish_function_path $fish_function_path \
	$HOME/.config/fish/functions/prodigy


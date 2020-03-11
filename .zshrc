# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/anaconda3/bin:$PATH"  # commented out by conda initialize
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export RUSTC_WRAPPER="sccache"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

POWERLEVEL9K_MODE="awesome-patched"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(anaconda status root_indicator background_jobs history time)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  dotenv
  vscode
  brew
  common-aliases
#  docker
#  encode64
#  extract	
  osx
  screen
  sudo
  zsh-syntax-highlighting
  #zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="nano ~/.zshrc"
alias ohmyzsh="nano ~/.oh-my-zsh"

alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="sudo osascript -e 'set volume 10'"

# Get readable list of network IPs
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias flush="dscacheutil -flushcache" # Flush DNS cache

alias gzip="gzip -9n" # set strongest compression level as ‘default’ for gzip
alias ping="ping -c 5" # ping 5 times ‘by default’
alias ql="qlmanage -p 2>/dev/null" # preview a file using QuickLook
alias matlab="/Applications/MATLAB_R2019b.app/bin/matlab -desktop &> /dev/null &"

alias dice="bash dice.sh" # dice

alias clc="clear" # clc == clear

alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

## z config
_zoxide_precmd() {
    zoxide add
}

precmd_functions+=_zoxide_precmd

z() {
    if [ $# -ne 0 ]; then
        _Z_RESULT=$(zoxide query "$@")
        case $_Z_RESULT in
            "query: "*)
                cd "${_Z_RESULT:7}"
                ;;
            *)
                echo "${_Z_RESULT}"
                ;;
        esac
    fi
}

alias zi="z -i"

alias za="zoxide add"
alias zq="zoxide query"
alias zr="zoxide remove"

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/chrisbetters/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/chrisbetters/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/Users/chrisbetters/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/chrisbetters/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# iterm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# プロンプト
autoload colors
colors
local p_cdir="%B%F{blue}[%~]%f%b"$'\n'
local p_mark="%B%(!,#,%%)%b"
PROMPT=" $p_cdir $p_mark "
PROMPT2="(%_) $p_mark "

# 右プロンプト(Gitの状態表示)
autoload -Uz vcs_info
setopt prompt_subst # プロンプトが表示されるたびに再評価
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats "[%b|%a]"
precmd () { vcs_info }
RPROMPT='${vcs_info_msg_0_}'

# エイリアス
alias ll="ls -lh"
alias la="ls -lha"
alias java="java -Dfile.encoding=UTF-8"
alias javac="javac -J-Dfile.encoding=UTF-8"
alias jar="jar -J-Dfile.encoding=UTF-8"

# 補完
autoload -U compinit && compinit

# tmuxでの実行時にxterm-256colorを設定する
[[ $TMUX != "" ]] && export TERM=xterm-256color

## keep background processes at full speed
setopt nobgnice

## restart running processes on exit
setopt nohup
setopt nocheckjobs


# プロンプト
autoload colors
colors
local p_cdir="%B%F{blue}[%~]%f%b"$'\n'
local p_mark="%B%(!,#,%%)%b"
PROMPT=" $p_cdir $p_mark "
PROMPT2="(%_) $p_mark "

# 右プロンプト
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
function git-current-branch {
  local name st color gitdir action
  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    return
  fi

  name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
  if [[ -z $name ]]; then
    return
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  if [[ -e "$gitdir/rprompt-nostatus" ]]; then
    echo "$name$action"
    return
  fi

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=%F{green}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=%F{yellow}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=%B%F{red}
  else
    color=%F{red}
  fi

  echo "$color$name$action%f%b"
}
setopt prompt_subst # プロンプトが表示されるために再評価
RPROMPT='[`git-current-branch`]'

# エイリアス
alias ll="ls -lh"
alias la="ls -lha"
alias java="java -Dfile.encoding=UTF-8"
alias javac="javac -J-Dfile.encoding=UTF-8"
alias jar="jar -J-Dfile.encoding=UTF-8"

# 補完
autoload -U compinit && compinit

## keep background processes at full speed
setopt nobgnice

## restart running processes on exit
setopt nohup
setopt nocheckjobs


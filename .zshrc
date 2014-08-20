# Prompt
autoload colors
colors
local p_cdir="%B%F{blue}[%~]%f%b"$'\n'
local p_info="%n@%m"
local p_mark="%B%(!,#,>)%b"
PROMPT=" $p_cdir$p_info $p_mark "
PROMPT2="(%_) $p_mark "

# Aliases
alias ll="ls -alh"
alias la="ls -a"
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


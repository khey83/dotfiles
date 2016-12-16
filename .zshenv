# JAVA_HOME
typeset -xT JAVA_HOME java_home
java_home=(
    $HOME/local/java(N-/)
)

# SCALA_HOME
typeset -xT SCALA_HOME scala_home
scala_home=(
    $HOME/local/scala(N-/)
)

# PATH
typeset -U path
path=(
  $SCALA_HOME/bin(N-/)
  $JAVA_HOME/bin(N-/)
  $HOME/local/bin(N-/)
  # システム
  /usr/local/bin(N-/)
  /usr/bin(N-/)
  /bin(N-/)
  /usr/sbin(N-/)
  /sbin(N-/)
)

# SUDO_PATH
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

# ファイルが存在したら読み込む関数
load_if_exists () {
    if [ -e $1 ]; then
        source $1
    fi
}

# HomebrewのGitHub用のAPIトークン
load_if_exists ".brew_github_api_token"


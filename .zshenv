# SCALA_HOME
typeset -xT SCALA_HOME scala_home
scala_home=(
    $HOME/local/scala(N-/)
)

# PATH
typeset -U path
path=(
  # 自分用
  $HOME/local/bin(N-/)
  # Scala
  $SCALA_HOME/bin(N-/)
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


# JAVA_HOME
## -x: export SUDO_PATHも一緒に行う。
## -T: SUDO_PATHとsudo_pathを連動する。
typeset -xT JAVA_HOME java_home
## (N-/): 存在しないディレクトリは登録しない。
##    パス(...): ...という条件にマッチするパスのみ残す。
##            N: NULL_GLOBオプションを設定。
##               globがマッチしなかったり存在しないパスを無視する。
##            -: シンボリックリンク先のパスを評価。
##            /: ディレクトリのみ残す。
java_home=(
  /System/Library/Frameworks/JavaVM.framework/Home(N-/)
)

# SCALA_HOME
typeset -xT SCALA_HOME scala_home
scala_home=(
    $HOME/local/scala(N-/)
)

# ANDROID_HOME
typeset -xT ANDROID_HOME android_home
android_home=(
  $HOME/local/android-sdk-macosx(N-/)
)

# ECLIPSE_HOME
typeset -xT ECLIPSE_HOME eclipse_home
eclipse_home=(
  $HOME/local/eclipse(N-/)
)

# パスの設定
## 重複したパスを登録しない。
typeset -U path
path=(
  # 自分用
  $HOME/local/bin(N-/)
  # Java
  $JAVA_HOME/bin(N-/)
  # Scala
  $SCALA_HOME/bin(N-/)
  # Android SDK
  $ANDROID_HOME/tools(N-/)
  $ANDROID_HOME/platform-tools(N-/)
  # Eclipse
  $ECLIPSE_HOME(N-/)
  # システム
  /usr/local/bin(N-/) # Homebrewの実行ファイルのデフォルトのインストールパス
  /usr/bin(N-/)
  /bin(N-/)
  /usr/sbin(N-/)
  /sbin(N-/)
)

# SUDO_PATH
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

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
  # Android SDK
  $ANDROID_HOME/tools(N-/)
  $ANDROID_HOME/platform-tools(N-/)
  # Eclipse
  $ECLIPSE_HOME(N-/)
  # システム
  /usr/local/bin(N-/) # Homebrewの実行ファイルのデフォルトのインストールパス
  /usr/bin(N-/)
  /bin(N-/)
)

# SUDO_PATH
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

# man用パスの設定
typeset -U manpath
manpath=(
  # 自分用
  $HOME/local/share/man(N-/)
  /usr/local/share/man(N-/)
  /usr/share/man(N-/)
)

# ページャの設定
if type lv > /dev/null 2>&1; then
    ## lvを優先する。
    export PAGER="lv"
else
    ## lvがなかったらlessを使う。
    export PAGER="less"
fi

# lvの設定
## -c: ANSIエスケープシーケンスの色付けなどを有効にする。
## -l: 1行が長くと折り返されていても1行として扱う。
##     （コピーしたときに余計な改行を入れない。）
export LV="-c -l"

if [ "$PAGER" != "lv" ]; then
    ## lvがなくてもlvでページャーを起動する。
    alias lv="$PAGER"
fi

# lessの設定
## -R: ANSIエスケープシーケンスのみ素通しする。
export LESS="-R"

# grepの設定
## GNU grepがあったら優先して使う。
if type ggrep > /dev/null 2>&1; then
    alias grep=ggrep
fi
## grepのバージョンを検出。
grep_version="$(grep --version | head -n 1 | sed -e 's/^[^0-9.]*\([0-9.]*\)[^0-9.]*$/\1/')"
## デフォルトオプションの設定
export GREP_OPTIONS
### バイナリファイルにはマッチさせない。
GREP_OPTIONS="--binary-files=without-match"
case "$grep_version" in
    1.*|2.[0-4].*|2.5.[0-3])
	;;
    *)
	### grep 2.5.4以降のみの設定
        ### grep対象としてディレクトリを指定したらディレクトリ内を再帰的にgrepする。
	GREP_OPTIONS="--directories=recurse $GREP_OPTIONS"
	;;
esac
### 拡張子が.tmpのファイルは無視する。
GREP_OPTIONS="--exclude=\*.tmp $GREP_OPTIONS"
## 管理用ディレクトリを無視する。
if grep --help 2>&1 | grep -q -- --exclude-dir; then
    GREP_OPTIONS="--exclude-dir=.svn $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.git $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.deps $GREP_OPTIONS"
    GREP_OPTIONS="--exclude-dir=.libs $GREP_OPTIONS"
fi
### 可能なら色を付ける。
if grep --help 2>&1 | grep -q -- --color; then
    GREP_OPTIONS="--color=auto $GREP_OPTIONS"
fi

# sedの設定
## GNU sedがあったら優先して使う。
if type gsed > /dev/null 2>&1; then
    alias sed=gsed
fi

# エディタの設定
## emacsを使う。
export EDITOR=emacs

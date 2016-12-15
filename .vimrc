set encoding=utf-8
scriptencoding utf-8
" ↑1行目は読み込み時の文字コードの設定
" ↑2行目はVim Script内でマルチバイトを使う場合の設定
" Vim scritptにvimrcも含まれるので、日本語でコメントを書く場合は先頭にこの設定が必要になる

"==============================================="
" プラグイン管理(NeoBundle)
"==============================================="
if has('vim_starting')
  " 初回起動時のみruntimepathにNeoBundleのパスを指定する
  set runtimepath+=~/.vim/bundle/neobundle.vim/

  " NeoBundleが未インストールであればgit cloneする
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install NeoBundole..."
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundole.vim")
  endif
endif

call neobundle#begin(expand('~/.vim/bundle'))

" インストールするプラグインを以下に記述

" NeoBundle自身を管理
NeoBundleFetch 'Shougo/neobundle.vim'
" カラースキームmolokai
NeoBundle 'tomasr/molokai'
" ステータスラインの表示内容強化
NeoBundle 'itchyny/lightline.vim'
" 末尾の全角と半角の空白文字を赤くハイライト
NeoBundle 'bronson/vim-trailing-whitespace'
" インデントの可視化
NeoBundle 'Yggdroot/indentLine'
" Unite
NeoBundle 'Shougo/unite.vim'
" NerdTree
NeoBundle 'scrooloose/nerdtree'
" VimSurround
NeoBundle 'tpope/vim-surround'
" VimScala
NeoBundle 'derekwyatt/vim-scala'

call neobundle#end()

" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on

" 未インストールのプラグインがあるかどうかチェックする
NeoBundleCheck

"==============================================="
" 文字コード
"==============================================="
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別
set fileformats=unix,dos,mac " 改行コードの自動判別
set ambiwidth=double " □や○が崩れる問題を解決

"==============================================="
" タブ・インデント
"==============================================="
set expandtab " タブをスペースに置き換える
set tabstop=2 " 画面上でタブが占める幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行でインデントを引き継ぐ
set smartindent " インデントを文脈に合わせて増減させる
set shiftwidth=2 " 自動インデントの幅

"==============================================="
" 文字列検索
"==============================================="
set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト

" ビジュアルモードで選択した範囲を「*」で検索可能にする
vnoremap * "zy:let @/ = @z<CR>n

" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

"==============================================="
" カーソル
"==============================================="
set whichwrap=b,s,h,l,<,>,[,],~" カーソルの左右移動で行末から次の行の行頭へ移動する
set number " 行番号を表示させる
set cursorline " カーソルラインをハイライト

" カーソル行全体をハイライト
highlight CursorLine cterm=NONE ctermfg=white ctermbg=black gui=NONE guifg=white guibg=black

" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

set display=lastline " 最終行で表示できない文字を出来るだけ表示する

"==============================================="
" 括弧・タグジャンプ
"==============================================="
set showmatch " 括弧の対応関係を一瞬表示する
source $VIMRUNTIME/macros/matchit.vim " Vimの%を拡張する

"==============================================="
" コマンド補完
"==============================================="
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンドの履歴数

"==============================================="
" マウスの有効化
"==============================================="
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

"==============================================="
" スワップ・バックアップファイル
"==============================================="
set noswapfile " スワップファイルを作成しない
set nobackup " バックアップファイルを作成しない

"==============================================="
" キー入れ替え
"==============================================="
" ; <-> : (ノーマルモードのみ)
noremap ; :
noremap : ;

"==============================================="
" プラグイン設定
"==============================================="
"+++++++++++++++++++++++++++++++++++++++++++++++"
" unite.vim
"+++++++++++++++++++++++++++++++++++++++++++++++"
"インサートモードで開始
let g:unite_enable_start_insert = 1
"最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 50
"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''
"絞り込みで曖昧検索をする
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
"キーバインド
"uniteを起動する接頭辞
nnoremap [unite] <Nop>
nmap <S-t> [unite]
"現在開いているファイルのディレクトリ下のファイル一覧。
nnoremap [unite]f :<C-u>Unite -buffer-name=files file_rec/async<CR>
"modelsディレクトリ下のファイル一覧。
nnoremap [unite]m :<C-u>Unite -buffer-name=files file_rec/async:app/models/<CR>
"viewsディレクトリ下のファイル一覧。
nnoremap [unite]c :<C-u>Unite -buffer-name=files file_rec/async:app/views/<CR>
"controllersディレクトリ下のファイル一覧。
nnoremap [unite]c :<C-u>Unite -buffer-name=files file_rec/async:app/controllers/<CR>
"バッファ一覧
nnoremap [unite]b :<C-u>Unite buffer<CR>
"レジスタ一覧
nnoremap [unite]r :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
"nnoremap [unite]m :<C-u>Unite file_mru<CR>
"ブックマーク一覧
"nnoremap [unite]c :<C-u>Unite bookmark<CR>
"ブックマークに追加
"nnoremap [unite]a :<C-u>UniteBookmarkAdd<CR>
"uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
	"ESCでuniteを終了
	nmap <buffer> <ESC> <Plug>(unite_exit)
	"挿入モードのときjjでノーマルモードに移動
	imap <buffer> jj <Plug>(unite_insert_leave)
	"挿入モードのときctrl+wでバックスラッシュも削除
	imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
	"ctrl+jで縦に分割して開く
	nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
	inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
	"ctrl+jで横に分割して開く
	nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
	inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
	"ctrl+oでその場所に開く
	nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
	inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
	"ctrl+tで新しいタブで開く
	nnoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')
	inoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')
endfunction"}}}
"-----------------------------------------------"
" molokaiの設定
"-----------------------------------------------"
if neobundle#is_installed('molokai') " molokaiがインストールされていれば
  colorscheme molokai " カラースキームにmolokaiを設定する
endif

"-----------------------------------------------"
" ステータスラインの設定
"-----------------------------------------------"
set laststatus=2
set showmode " 現在モードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの現在位置を表示する

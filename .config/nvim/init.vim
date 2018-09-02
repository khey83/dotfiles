"==============================================="
" プラグイン管理(dein.vim)
"==============================================="
" dein.vimのキャッシュディレクトリ
let s:dein_dir = expand('~/.cache/dein')
"
" dein.vim本体のキャッシュディレクトリ
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vimが存在していない場合はgithubからclone
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" dein.vimでプラグインをロード
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " dein.toml, dein_lazy.tomlファイルのディレクトリをセット
  let s:toml_dir = expand('~/.config/nvim')

  " 起動時に読み込むプラグイン群
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})

  " 遅延読み込みしたいプラグイン群
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

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
" マウス有効化
"==============================================="
set mouse=a

"==============================================="
" カーソル
"==============================================="
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭へ移動する
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
" タブページ切り替え
"==============================================="
nnoremap <Leader>[ :<C-u>tabprev<CR>
nnoremap <Leader>] :<C-u>tabnext<CR>

"==============================================="
" プラグイン設定
"==============================================="
"-----------------------------------------------"
" colorschemeの設定
"-----------------------------------------------"
autocmd ColorScheme * highlight Comment cterm=bold ctermfg=250 guifg=#bcbcbc
autocmd ColorScheme * highlight Delimiter ctermfg=250 guifg=#bcbcbc
colorscheme molokai " カラースキームにmolokaiを設定する

"-----------------------------------------------"
" ステータスラインの表示内容強化(lightline.vim)
"-----------------------------------------------"
set laststatus=2
set showmode " 現在モードを表示
set showcmd " 打ったコマンドをステータスラインの下に表示
set ruler " ステータスラインの右側にカーソルの現在位置を表示する

"-----------------------------------------------"
" NERDTree
"-----------------------------------------------"
nnoremap <silent> <Leader>n :<C-u>NERDTreeToggle<CR> " NERDTreeを開く
let g:NERDTreeShowHidden=1 " ドットで始まるファイル/ディレクトリを表示


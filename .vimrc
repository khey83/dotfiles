set nocompatible
"==============================================="
" プラグイン管理(neobundle.vim)
"==============================================="
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

filetype off
filetype plugin indent off
call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'derekwyatt/vim-scala'

call neobundle#end()
filetype plugin indent on

"==============================================="
" 基本設定
"==============================================="
colorscheme desert "カラースキーマ

set expandtab "タブ入力をスペースに置き換える
set tabstop=2 "画面上でタブが占める幅
set shiftwidth=2 "自動インデントの幅
set autoindent "改行でインデントを引き継ぐ
set smartindent "インデントを文脈に合わせて増減させる

set directory=~/.vim/tmp "スワップファイルの保存先
set backupdir=~/.vim/tmp "バックアップファイルの保存先
set undodir=~/.vim/tmp "undoファイルの保存先

".vimrcを開く
nnoremap mrc :<C-u>edit $MYVIMRC<CR>
".vimrcを読み込む
nnoremap mload :<C-u>source $MYVIMRC<CR>
"検索のハイライトを消す
nnoremap <ESC><ESC> :<C-u>noh<CR>
"0レジスタペースト
nnoremap <C-p> "0p
vnoremap <C-p> "0p

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
"uniteを起動する接頭辞
nnoremap [unite] <Nop>
nmap ,u [unite]
"現在開いているファイルのディレクトリ下のファイル一覧。
nnoremap [unite]f :<C-u>Unite file_rec/async<CR>
"modelsディレクトリ下のファイル一覧。
nnoremap [unite]m :<C-u>Unite file_rec/async:app/models/<CR>
"viewsディレクトリ下のファイル一覧。
nnoremap [unite]c :<C-u>Unite file_rec/async:app/views/<CR>
"controllersディレクトリ下のファイル一覧。
nnoremap [unite]c :<C-u>Unite file_rec/async:app/controllers/<CR>
"ファイルの新規作成
nnoremap [unite]n :<C-u>UniteWithBufferDir file file/new -buffer-name=file<CR>
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

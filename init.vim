" ================================================================================================
" auto-command                                                    -
" ================================================================================================
" 设置重新进入文件时，光标留在上次退出的地方
augroup back_to_leave
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
" 加载资源配置
source ~/AppData/Local/nvim/config/_machine_specific.vim
source ~/AppData/Local/nvim/my-vim/md.vim

" ================================================================================================
" ===============插件安装================
" ================================================================================================
let mapleader=" "
call plug#begin('~/AppData/Local/nvim/plugged') "Vim 插件的安装路径，可以自定义。
"~ 表示系统路径，在windows下为 C:/User/username/
Plug 'vim-airline/vim-airline'
"另外查找用法
Plug 'godlygeek/tabular'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-json'
Plug 'neoclide/coc-tsserver'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ellisonleao/gruvbox.nvim'
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-startify'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tracyone/fzf-funky',{'on': 'FzfFunky'}
Plug 'Yggdroot/indentLine'
Plug 'easymotion/vim-easymotion'

" Markdown
Plug 'fannheyward/coc-markdownlint'
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'ferrine/md-img-paste.vim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'SirVer/ultisnips'
"将所有插件安装在这里
call plug#end()
" ================================================================================================
" = Basic settings =====================================
" ================================================================================================
set clipboard+=unnamed
set ignorecase
set scrolloff=30
set history=200
"忽略大小写
set ignorecase
"智能匹配
set smartcase
"行号
set number
"相对行号
set relativenumber
set incsearch
set hlsearch
"突出显示当前行
set cursorline
"set sizeSize
let s:fontsize = 12
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "GuiFont! Consolas:h" . s:fontsize
endfunction
noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a
" ================================================================================================
" = No Leader Keymaps =====================================
" ================================================================================================
" last changed in current buffer(file)
noremap ga '.
"save
noremap <C-s> :w<CR>
noremap K 5k
noremap J 5j
noremap W 5w
noremap B 5b
" gh key: go to the first word the line
noremap gh ^
" gl key: go to the end of the line
noremap gl $
" 插入模式移动光标
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-d> <Delete>
" ================================================================================================
" = Resize splits with arrow keys =====================================
" ================================================================================================
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

"================================================================================
"===================gruvbox主题设置===========================
"===================================================================================
"背景
set background=dark " or light if you want light mode
"主题
colorscheme gruvbox

" ================================================================================================
" 👻👻👻 Which-Key 配置👻👻👻
" ================================================================================================
let g:mapleader = "\<Space>"
set timeoutlen=500
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
call which_key#register('<Space>', "g:which_key_map", 'n')
" Define prefix dictionary
let g:which_key_map =  {}


noremap <leader><CR> :nohlsearch<CR>

" a:
nmap <leader>A maggVG
let g:which_key_map.A = 'Selct All'

" Adjacent duplicate words
"noremap <LEADER>dw /\(\<\w\+\>\)\_s*\1

" e: Toggle Explorer ⭐️
map <leader>e :NERDTree<CR>
map <leader>e :NERDTreeToggle<CR>
let g:which_key_map.e = 'Toggle Explorer'

" Press space twice to jump to the next '<++>' and edit it
nnoremap <leader>f <Esc>/<++><CR>:nohlsearch<CR>c4l
"FzfFunky
nnoremap <leader>fu :FzfFunky<Cr>
" i: Insert ⭐️
nmap <leader>i f(a
let g:which_key_map.i = 'Insert after ('

" j: page down
noremap <leader>j  <C-d>
let g:which_key_map.j ='PageDown'

" k: page up
noremap <leader>k  <C-u>
let g:which_key_map.k ='PageUp'


" p: paste
nnoremap <leader>P "bp
let g:which_key_map.P ='PasteFromSelectAll'
" q:quit and save	
nmap <leader>q :wq<CR>
let g:which_key_map.q ='CloseThisWindow'

" s: ⭐️
nmap <leader>s <Plug>(easymotion-s2)
let g:which_key_map.s ='Easymotion'

" w: Window ⭐️

"===================================================================================
" === Window management =====================
"===================================================================================
map <leader>wc <C-W>c
map <leader>wk <C-W>k
map <leader>wj <C-W>j
map <leader>wh <C-W>h
map <leader>wl <C-W>l

let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'c' : ['<C-W>c'     , 'CloseWindow']         ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ }

" y: copy all
nmap <leader>Y maggVG"by
let g:which_key_map.Y ='CopyAll'

"tagbar
nmap <c-u> :TagbarToggle<CR>

"FZF

"===================================================================================
"===================markdown===========================
"===================================================================================
"======vim-markdown====
"禁用选项仅控制 Vim Markdown 特定折叠配置。
let g:vim_markdown_folding_disabled = 1
"======md-img-pasete.vim====
" 设置快捷键 Ctrl+p  粘贴剪切板中的图片
autocmd FileType markdown nnoremap <silent> <C-p> :call mdip#MarkdownClipboardImage()<CR>F%i
"设置默认储存文件夹。这里表示储存在当前文档所在文件夹下的'pic'文件夹下，相当于 ./pic/
let g:mdip_imgdir = 'E:/MarkdownPic/'
let g:mdip_imgname = 'image'
"======MarkdownPreview====
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_page_title = '「${name}」'
" for normal mode
nnoremap ,r <Plug>MarkdownPreview
" for insert mode
imap ,r <Plug>MarkdownPreview
" for normal mode
nnoremap ,rs <Plug>StopMarkdownPreview
" for insert mode
imap ,rs <Plug>StopMarkdownPreview


"===================================================================================
" === vim-markdown-toc =====================
"===================================================================================
"在当前光标后生成目录
":GenTocMarked
"更新目录
":UpdateToc
"取消储存时自动更新目录
let g:vmt_auto_update_on_save = 0
"===================================================================================
" === Screens management =====================
"===================================================================================
" Disabling the default s key
noremap s <nop>
" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
map sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
map sj :set splitbelow<CR>:split<CR>
map sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
map sl :set splitright<CR>:vsplit<CR>


"===================================================================================
" === Tab management ==========================
"===================================================================================
" Create a new tab with tu
map tu :tabe<CR>
" Move around tabs with tn and ti
map H :-tabnext<CR>
map L :+tabnext<CR>
" Move the tabs with tmn and tmi
map tmn :-tabmove<CR>
map tmi :+tabmove<CR>
"===================================================================================
" === vim-table-mode
"===================================================================================
map <leader>ta :TableModeToggle<CR>
function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
      \ <SID>isAtStartOfLine('\|\|') ?
      \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
      \ <SID>isAtStartOfLine('__') ?
      \ '<c-o>:silent! TableModeDisable<cr>' : '__'
"===================================================================================
"========= Ultisnips=========
"===================================================================================
"设置tab键为触发键
let g:UltiSnipsExpandTrigger = '<tab>'
"设置向后跳转键
let g:UltiSnipsJumpForwardTrigger = '<tab>' 
"设置向前跳转键
let g:UltiSnipsJumpBackwardTrigger = '<S-tab>' 
"设置文件目录
let g:UltiSnipsSnippetDirectories=["Ultisnips"]
"设置打开配置文件时为垂直打开
let g:UltiSnipsEditSplit="vertical"
"===================================================================================
"========= Insert map =========
"===================================================================================
inoremap ,; <ESC>A;<ESC>

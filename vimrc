runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype on "开启文件类型侦测
filetype plugin on "根据侦测到的不同类型加载对应的插件
set incsearch "开启实时搜索功能"
set ignorecase "搜索时忽略大小写"
set nocompatible "不兼容vi"
set wildmenu "vim自身命令行模式智能补全"
set ruler "显示光标当前位置"
set cursorline "当前行下划线"
set cursorcolumn "高亮显示当前列"
set hlsearch "高亮显示搜索结果"
set fencs=utf-8,chinese,latin1 
set enc=utf-8 "设置编码"

let mapleader="," "重定义leader键
filetype indent on "自适应不同语言的智能缩进
"let g:indent_guides_enable_on_vim_startup=1 "随vim自启动
let g:indent_guides_start_level=2 "第二层开始可视化缩进
let g:indent_guides_guide_size=1 "色块宽度
":nmap <silent> <leader>z <Plug>IndentGuidesToggle "快捷键z开/关缩进可视化

set foldmethod=indent "基于缩进或语法进行代码折叠
"set foldmethod=syntax "拖慢速度?
set nofoldenable "启用时关闭折叠代码

"taglist配置
let Tlist_Ctags_Cmd='/usr/local/bin/ctags' "设定ctags程序的位置
let Tlist_Show_One_File=1 "只显示当前文件的tag
let Tlist_Exit_OnlyWindow=1 "若taglist窗口是最后一个,则退出
let Tlist_Use_Right_Window=1 "taglist显示在右侧
let Tlist_Use_SingleClick=1 "单击即跳转到定义
let Tlist_Auto_Open=0 "不随vim启动
let Tlist_Process_File_Always=1 "始终解析文件中的tag
let Tlist_File_Fold_Auto_Close=1 "同时显示多个文件时,其它文件的tag折叠
map <F4> :TlistToggle <CR>
map <F2> :NERDTreeToggle<CR>
nmap <F3> :TagbarToggle<CR>
let g:tagbar_width=25

"if has("cscope")
	"set csprg=/usr/bin/cscope "指定用来执行 cscope 的命令
	"set csto=1 "先搜索tags标签文件，再搜索cscope数据库
	"set cst  "使用|:cstag|(:cs find g)，而不是缺省的:tag
	"set nocsverb  "不显示添加数据库是否成功
	"" add any database in current directory
	"if filereadable("cscope.out")
		"cs add cscope.out "添加cscope数据库
	""endif
	""set csverb "显示添加成功与否
	"else  
		"let cscope_file=findfile("cscope.out", ".;")  
		"let cscope_pre=matchstr(cscope_file, ".*/")  
		"if !empty(cscope_file) && filereadable(cscope_file)  
			"exe "cs add" cscope_file cscope_pre  
		"endif        
	"endif
"endif
if has("cscope") && filereadable("/usr/bin/cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst 
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
		" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif

nmap <leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>sc :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>si :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader>sd :cs find d <C-R>=expand("<cword>")<CR><CR>

"ycm
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_complete_in_comments=1 " 补全功能在注释中同样有效
let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 标签补全引擎
let g:ycm_seed_identifiers_with_syntax=1 " 语法关键字补全
set completeopt-=preview " 补全内容不以分割子窗口形式出现，只显示补全列表
"let g:ycm_min_num_of_chars_for_completion=1 " 从第一个键入字符就开始罗列匹配项
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
let g:ycm_register_as_syntastic_checker=0

nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
" 只能是 #include 或已打开的文件
nnoremap <leader>je :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jg :YcmCompleter GoToDefinitionElseDeclaration<CR>
inoremap <leader>; <C-x><C-o>

function Generate_cscope()
	!find $PWD -name "*.h" -o -name "*.cpp" > cscope.files
	!cscope -bkq -i cscope.files
endfunction

set tags=tags;
set autochdir
set tags+=/usr/include/tags
set tags+=/usr/local/include/tags
nmap <leader>ct :!ctags -R --fields=+iaS --extra=+q *<CR>
nmap <leader>ce : call Generate_cscope()<CR>

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_include_dirs =['/home/test'] 

"autopairs
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'

"*.cpp 和 *.h 间切换
nmap <Leader>ch :A<CR>
" 子窗口中显示 *.cpp 或 *.h
nmap <Leader>sch :AS<CR>"

" 设置 pullproto.pl 脚本路径
 let g:protodefprotogetter='~/.vim/bundle/vim-protodef/pullproto.pl'
" 成员函数的实现顺序与声明顺序一致
let g:disable_protodef_sorting=1"

"doxygen
"let g:DoxygenToolkit_briefTag_pre="@Name: "
"let g:DoxygenToolkit_paramTag_pre="@Param: "
"let g:DoxygenToolkit_returnTag   ="@Returns: "
let g:DoxygenToolkit_blockHeader="*******************************************************"
let g:DoxygenToolkit_blockFooter="*******************************************************"
let g:DoxygenToolkit_authorName="chimmu"
let g:DoxygenToolkit_licenseTag="Copyright (C) chimmu"
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:doxygen_enhanced_color=1
let g:load_doxygen_syntax=1
nmap <leader>do :Dox<CR>
nmap <leader>da :DoxAuthor<CR>
nmap <leader>dl :DoxLic<CR>

" 按 ctrl-D 开始准备输入  
"nnoremap <C-D> :CtrlSF<space>  
" <C-C>查找光标下单词  
"nmap <C-C> :CtrlSF<space><C-R>=expand("<cword>")<CR><CR>  
" 也可以用 <C-W>表示光标下单词  
"nmap <C-C> :CtrlSF<space><CR><C-W><CR>)"
"nmap <leader>p :CtrlP<CR>


"let g:ycm_key_list_select_completion = ['<tab>','<c-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
"" UltiSnips 的 tab 键与 YCM 冲突，重新设定
"let g:UltiSnipsExpandTrigger="<leader><tab>"
"let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
"let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"
function! s:insert_gates()
	  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
	    execute "normal! i#ifndef " . "_" . gatename . "_"
	      execute "normal! o#define " . "_" . gatename . "_" . " "
	        execute "normal! Go#endif /* " . "_" . gatename . "_" . " */"
		  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

"showfunc
nmap <leader>ef <Plug>ShowFunc

"pydiction
let g:pydiction_location = "~/.vim/bundle/pydiction/complete-dict"

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'b4b4r07/vim-hcl'
Plugin 'chr4/nginx.vim'
Plugin 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
Plugin 'egberts/vim-syntax-bind-named'
Plugin 'itspriddle/vim-shellcheck'
Plugin 'ledger/vim-ledger'
Plugin 'lepture/vim-jinja'
Plugin 'Matt-Deacalion/vim-systemd-syntax'
Plugin 'nathangrigg/vim-beancount'
Plugin 'pearofducks/ansible-vim'
Plugin 'rhysd/committia.vim'
Plugin 'stephpy/vim-yaml'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-scripts/bash-support.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'VundleVim/Vundle.vim'
Plugin 'wakatime/vim-wakatime'
Plugin 'yasuhiroki/github-actions-yaml.vim'
" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin on

syntax on
set ts=2 sts=2 sw=2 et modeline

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:ansible_unindent_after_newline = 1
let g:ansible_yamlKeyName = 'yamlKey'
let g:ansible_name_highlight = 'd'
let g:ansible_extra_keywords_highlight = 1
let g:ansible_normal_keywords_highlight = 'Constant'
let g:ansible_attribute_highlight = "ob"


au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja
au BufNewFile,BufRead *.rst set sts=3 sw=3 ts=3 ft=rst
au BufNewFile,BufRead *.service set sts=2 sw=2 ts=2 ft=systemd
au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead *.bean,*.beancount setf beancount

au BufNewFile,BufRead accounts,journal,register,*.journal,*.ldg,*.ledger setf ledger | comp ledger


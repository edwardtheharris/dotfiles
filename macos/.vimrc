let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" set the runtime path to include Vundle and initialize
call plug#begin()
Plug 'andrewstuart/vim-kubernetes'
Plug 'b4b4r07/vim-hcl'
Plug 'chr4/nginx.vim'
Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
Plug 'egberts/vim-syntax-bind-named'
Plug 'itspriddle/vim-shellcheck'
Plug 'ledger/vim-ledger'
Plug 'lepture/vim-jinja'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'nathangrigg/vim-beancount'
Plug 'pearofducks/ansible-vim'
Plug 'rhysd/committia.vim'
Plug 'rottencandy/vimkubectl'
Plug 'stephpy/vim-yaml'
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/bash-support.vim'
Plug 'vim-syntastic/syntastic'
Plug 'VundleVim/Vundle.vim'
Plug 'wakatime/vim-wakatime'
Plug 'yasuhiroki/github-actions-yaml.vim'
" All of your Plugs must be added before the following line
call plug#end()

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
au BufNewFile,BufRead *.yml set ft=yaml
au BufNewFile,BufRead *.rst set sts=3 sw=3 ts=3 ft=rst
au BufNewFile,BufRead *.service set sts=2 sw=2 ts=2 ft=systemd
au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead accounts,journal,register,*.journal,*.ldg,*.ledger setf ledger | comp ledger
au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
au BufNewFile,BufRead openssl.cnf set ft=dosini
au BufNewFile,BufRead *.zone setf bindzone
au BufNewFile,BufRead named.conf setf named

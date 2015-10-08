# workstationCreation
This repo contains scripts to streamline workflows on an efficient linux workstation using git, latexmk, and vim. This README.md lists steps to configure the requisite software for using the workflow, as well as the workflow. Steps are listed in the order I take them.

## Part A: Easily Run a Linux Workstation Alongside ChromeOS!
1. Put the chromebook in developer-mode.
2. Download crouton from https://goo.gl/fd3zc .
3. Enter the shell(AKA the terminal or the command-line) by pressing control-alt-t and typing ```shell```
4. Change directory(cd) to your Downloads folder (because that's where crouton downloads to):``` $ cd ~/Downloads ```
5. Install a nicely packaged chroot-environment that runs alongside ChromeOS: ``` sh -e ./crouton -r trusty -t lxde ```
  * available releases are listed when the following command is entered at chrome's shell: ```sh -e crouton -r list```
  * available targets are listed when the following command is entered at chrome's shell: ```sh -e ./crouton -t list```
  * A chroot-environment can be named with passing the flag -n to crouton followed by the desired name, e.g. ```sh -e crouton -r trusty -t lxde -n myDesiredNameInPlaceOfThisCamelCasedCraziness```
6. Enter the chroot-environment with ```enter-chroot``
7. Install useful software and work more efficiently than ever.

## Part B: Install Useful Software
### for Debian, Ubuntu, and Mint: 
```bash
$ sudo apt-get update; sudo apt-get install git curl i3 dmenu texlive sshfs feh rsync texlive-publisher texlive-math-extra texlive-latex-recommended texlive-xelatex latexmk biber evince
```

### for Arch:
```bash
$ sudo pacman -S i3 vim evince git dmenu xorg lxterminal alsa-tools texlive-most python python-numpy python-matplotlib ipython 
adopt lxterminal by editing ~/.i3/config:
just under the line "set $mod = Mod1", add this line:
set $term = lexterminal
```

Use colored prompts to visually distinguish the root-shell-prompt from the user-shell-prompt and beautify
both:
```bash
$ echo "PS1='\[\e[4;33m\]\u\[\e[m\]\[\e[1;34m\]\w\[\e[m\]\[\e[1;32m\]\$\[\e[m\] \[\e[0;37m\]'" >> ~/.bashrc
$ su
# echo "PS1='\[\e[0;31m\]\u\[\e[m\]\[\e[1;34m\]\w\[\e[m\]\[\e[0;31m\]#\[\e[m\]\[\e[0;37m\] '" >> ~/.bashrc
```

Place wallpapers in ~/.wallpaper and randomize wallpaper prior to loading i3 with this script:
```~/.bin/wallpaper-setter-script.sh``` :
```
#!sh
feh --bg-max --randomize ~/.wallpaper/* &
```

### Setup VIM:
echo good initial settings into ~/.vimrc:
```bash
$ echo 'syntax on
filetype plugin indent on
set t_Co=256
set whichwrap+=<,>,h,l,[,] " allow left/right nav. across newlines
set number " enable line-numbering' >> ~/.vimrc
```

Get the wombat256mod colorscheme by downloading wombat256mod.vim from http://www.vim.org/scripts/script.php?script_id=2465
```bash
$ mkdir -p ~/.vim/colors
$ curl http://www.vim.org/scripts/download_script.php?src_id=13400 > ~/.vim/wombat256mod.vim
$ echo 'colorscheme wombat256mod " set a nice colorscheme' >> ~/.vimrc```
```

Install vim's pathogen plugin manager:
```bash
$ mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
$ echo 'execute pathogen#infect()' >> ~/.vimrc
```

install the vim-airline plugin:
```bash
$ git clone https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline
$ echo 'set laststatus=2' >> ~/.vimrc
```

Install the syntastic plugin:
```bash
$ cd ~/.vim/bundle && \
  git clone https://github.com/scrooloose/syntastic.git
```

Install vim-auto-save plugin and enable it on startup
```bash
$ mkdir ~/.vim/bundle/vim-auto-save &&\
curl git@github.com:vim-scripts/vim-auto-save.git > ~/.vim/bundle/vim-auto-save &&\
echo 'let g:auto_save = 1 " enable AutoSave(from plugin vim-auto-save) on Vim startup' >> ~/.vimrc
```

Make the touchpad behave in a less frustrating manner by turning off tap-to-click and vertical edge-scrolling:
```bash
echo '''synclient MaxTapTime=0 VertEdgeScroll=0 HorizTwoFingerScroll=1
```

Tags: 
linux,
vim,
tiling window manager,
latex workflow,
latexmk,
i3,
wetlife's blog

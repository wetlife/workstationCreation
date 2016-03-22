# workstationCreation
This repo contains scripts to streamline workflows on an efficient linux workstation using git, latexmk, and vim. This README.md lists steps to configure the requisite software for using the workflow as well as the workflow. Steps are listed in the order I take them.

<<<<<<< HEAD
## Easily Run a Linux Workstation on Alongside ChromeOS on a Chromebook!
=======
## Part A: Easily Install and Rum a Linux Workstation on Alongside ChromeOS on a Chromebook!
>>>>>>> dfe6f0670db19b81e76c8da7feb0690daa92ed10
1. Put the chromebook in developer-mode.
2. Download crouton from https://goo.gl/fd3zc .
3. Enter the shell(AKA the terminal or the command-line) by pressing control-alt-t and typing `shell`
4. Change directory(cd) to your Downloads folder (because that's where crouton downloads to):`$ cd ~/Downloads`
5. Install a nicely packaged chroot-environment that runs alongside ChromeOS: `sh -e ./crouton -r trusty -t lxde`
  * available releases are listed when the following command is entered at chrome's shell: `sh -e crouton -r list`
  * available targets are listed when the following command is entered at chrome's shell: `sh -e ./crouton -t list`
  * A chroot-environment can be named with passing the flag -n to crouton followed by the desired name, e.g. `sh -e crouton -r trusty -t lxde -n myDesiredNameInPlaceOfThisCamelCasedCraziness`
6. Enter the chroot-environment with `enter-chroot`
7. Install useful software and work more efficiently than ever.

## Install Useful Software
### for Debian, Ubuntu, and Mint:
Install my most useful software with apt-get:
```bash
$ sudo apt-get update; sudo apt-get install git curl i3 dmenu texlive sshfs feh rsync texlive-publisher texlive-math-extra texlive-latex-recommended texlive-xelatex latexmk biber evince
```

### for Arch:
Install my most useful software with pacman:
```bash
$ sudo pacman -Sy i3 vim evince git dmenu xorg lxterminal alsa-tools texlive-most python python-numpy python-matplotlib ipython
```

adopt lxterminal by editing ~/.i3/config:
just under the line "set $mod = Mod1", add this line:
```bash
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
<<<<<<< HEAD
=======

>>>>>>> dfe6f0670db19b81e76c8da7feb0690daa92ed10
```bash
#!sh
feh --bg-max --randomize ~/.wallpaper/* &
`https://github.com/wetlife/workstationCreation.git``
```
### Get 256 colors in terminal:
write a line in <readline.something> to set colors to 256. Also use any gui preference-editor is in the chosen terminal emulator, though these won't allow setting 256 colors.

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
---
---
### Use and document plugin breakindent 
---
---

## Use the Workflow.
### Manage windows with i3:
* let i3 generate its configuration file and use `alt` as the modifier-key(mod) when prompted;
* start a terminal emulator with `alt-enter`
  * make use of tab-completion in the terminal: start typing a command and press tab; if nothing happens press tab again to see all possible completions;
* run commands and start applications by pressing `alt-d` and then typing the command(make use of tab completion here);
* vertically tile new windows with `alt-v`;
* horizontally tile new windows with `alt-h`;
* move focus between windows in the current workspace by holding down `alt` while pressing either `j`, `k`, `l`, `;`, or any arrow-key(you rob i3 of its power by moving your hands off the homerow);
* move windows within the current workspace by holding down `alt-shift` while pressing either `j`, `k`, `l`, `;`, or any arrow-key(you rob i3 of its power by moving your hands off the homerow);
* change workspaces by holding down `alt-<NUMBER>`, where `<NUMBER>` is a number-key;
* move the current window to a workspace by holding down `alt-shift-<NUMBER>`, where `<NUMBER>` is a number-key;
* many people do web browsing on one workspace, email on a second workspace, and work on a third workspace(it is nice to leave a set of windows open, do something else, and later instantly return to the original set of windows); and
* learn to use the keyboard rather than the mouse where possible and you'll experience great efficiency gains(before you know it, you will be the "wizard" who amazes others with flurries of wondrous keyboard-computing!)

<<<<<<< HEAD
### Use Git for Distributed Version Control
Setup the minimal configuration info:

* ```$ git config --global user.name "John Doe"```
* ```$ git config --global user.email johndoe@example.com```
* Create global git ignore file [```~/.gitignore_global```](git-workstation-config/.gitignore_global)
* Create a local [```.gitignore```](git-workstation-config) within each repository if it is desired to ignore a repo-specific-set of files and directories

### Write Technical Documents With $$\LaTeX$$ Like a Pro
A pleasing and efficient workflow to typeset technical documents is the workflow laid out beautifully
[here](http://dlpeterson.com/2013/08/latex-workflow/)
by Dale Lukas Peterson

### Setup Git
* Set global git parameters:

  * ```$ git config --global user.name "Kyle Thomas"```

  * ```$ git config --global user.email "wetlife@gmail.com```

---

### Become Powerful at the Command-Line:
* most commands have usage of the form `commandName --flag argument`
* `cd` changes the current directory;
* `pwd` prints the working directory;
* ```echo "all these words"``` prints out the string `all these words` to the screen;
* `cat` prints the contents of a text file;
* `tail -n 23 someFoo` prints the last 23 lines of text in file `someFoo`;
* use tab-completion to reduce unnecessary typing;
* know how to redirect and pipe output to create powerful command pipelines:
  * `|` pipes output of one program into another:
   * `progFoo | progToo` pipes output from `progFoo` into `progToo`;
  * `>` redirects command output (overwrites existing files!):
   * `foo > someFile` redirects standard output, which is what is seen printed to a terminal in response to a command;
   * `foo 2> fooBooHoo` redirects errors from command `foo` into file `fooBooHoo`; and
   * `&> /p/a/t/h/someFile` redirects standard out and standard error to the file named `someFile` located at `/p/a/t/h/`;
  * `>>` appends redirected standard output to a file
   * `echo "appendage" >> someFile` appends a newline and the text `appendage` to file `someFile`.

### Write Technical Documents With $\LaTeX$ Like a Pro
The most pleasing and efficient workflow I've used to typeset technical documents is using the workflow laid out beautifully [here by Dale Lukas Peterson](http://dlpeterson.com/2013/08/latex-workflow/):
- $`latexmk -pvc -pdf <file.tex>`
- $`vim <file.tex>`

The previewed pdf is recompiled and the preview is updated when changes to file.tex are saved.

## The Art of Copy-Pasta
### Windows' flavor(tastes like schnozberries):
- `<ctrl>-c` copies a selection
- `<ctrl>-x` copies then deletes a selection, which is commonly called "cut"-ing
- `<ctrl>-v` pastes
- `<ctrl>-f` finds text
- `<alt>-<tab> [-<tab>] [-<tab>] ...` switches applications
- `<ctrl>-<tab> [-<tab>] [-<tab>] ...` switches tabs
- `<ctrl>-w` closes a tab
- `<alt>-<F4>` closes an application
- `<ctrl>-<alt>-<delete>` opens dialog to access task manager or logoff
- `<ctrl>-<shift>-<escape>` opens the task manager
- `<ctrl>-<left arrow>` moves the cursor a "word" to the left
- `<ctrl>-<right arrow>` moves the cursor a "word" to the right
- `<ctrl>-<shift>-<left arrow>` selects the "word" to the left
- `<ctrl>-<shift>-<right arrow>` selects the "word" to the right
- `<ctrl>-<delete>` and `<ctrl>-<backspace>` kill entire words at a time
- pressing `<shift>` while pressing the `<left mouse button>` a second time selects everything selectable which flows between the last two locations the button was pressed
- pressing `<ctrl>` while selecting several items allows one to select those individual items

### vi-flavor:
- `i` enters insert mode
- `a` enters insert mode one position right of, or "after," the cursor's position
- `h`, `j`, `k`, and `l` move the cursor left, right, up, and down respectively while in normal mode
- `<escape>` and `<ctrl>-[` both move the cursor one position to the left and enter normal mode
- `w` moves forward a word
- `b` moves backward a word
- `r` replaces a selection or any character under the cursor with something
- `s` substitutes an arbitrary string of text for the selection or the character under the cursor

## Driving a Web Browser Efficiently
- `<ctrl>-l` selects all text in the address bar.
- Typing `<ctrl>-l`, `wikipedia`, then `<ctrl>-<enter>` www.wikipedia.com.

Tags: 
linux,
vim,
tiling window manager,
latex workflow,
latexmk,
i3,
wetlife's blog,
web browser,
terminal,
shell,
hotkeys,
keyboard shortcuts,
keyboard navigation,
driving a computer from the keyboard,


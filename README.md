# workstationCreation
This repo contains scripts image a machine which streamline workflows on an efficient linux workstation using bash, git, latexmk, and vim.
This README.md lists steps to configure the requisite software for using the workflow as well as the workflow.
Steps are listed in the order I take them.

## Easily Install and Run a Linux Workstation Alongside ChromeOS on a Chromebook
1. Put the chromebook in developer-mode.
2. Download crouton from [https://goo.gl/fd3zc].
3. Open ChromeOS's shell by pressing control-alt-t and typing `shell`
4. Change directory to your Downloads folder (because that's where crouton downloads to):`$ cd ~/Downloads`
5. Install a nicely packaged chroot-environment that runs alongside ChromeOS: `sh -e ./crouton -r trusty -t lxde`
  - available releases are listed when the following command is entered at chrome's shell: `sh -e crouton -r list`
  - available targets are listed when the following command is entered at chrome's shell: `sh -e ./crouton -t list`
  - A chroot-environment can be named with passing the flag -n to crouton followed by the desired name, e.g. `sh -e crouton -r trusty -t lxde -n myDesiredNameInPlaceOfThisCamelCasedCraziness`
6. Enter the chroot-environment with `enter-chroot`
7. Install useful software and work more efficiently than ever.

## Install Useful Software
### for Debian, Ubuntu, and Mint:
Install useful software with apt:
```bash
$ sudo apt-get update; sudo apt-get install git curl i3 dmenu texlive sshfs feh rsync texlive-publisher texlive-math-extra texlive-latex-recommended texlive-xelatex latexmk biber evince
```

### for Arch:
Install useful software with pacman:
```bash
$ sudo pacman -Sy i3 vim evince git dmenu xorg lxterminal alsa-tools texlive-most python python-numpy python-matplotlib ipython
```

## Adopt a Lovely Configuration
### These configurations require only a POSIX-compliant system.
POSIX compliance is the agreement that provides a homogeneous user interface across OSX, most big-name distributions(distros) of GNU/Linux, UNIX, BSD, and likely others your author omits out of ignorance.

#### Adopt lxterminal by editing ~/.i3/config:
just under the line "set $mod = Mod1", add this line:
```bash
set $term = lxterminal
```

#### Use Readline with Keybindings from Vi Rather than Emacs
Use the following commands to use vi-mode when entering commands. The first command sets the sysem-wide default behavior, but requires root priveleges to execute. The second command sets the current user's default behavior of readline.
1. `cp /etc/inputrc /tmp/ && echo 'set editing-mode vi' >> inputrc && sudo mv /tmp/inputrc /etc/`
2. `echo 'set editing-mode vi' >> ~/.inputrc`
3. press <CTRL><x><CTRL><r> to reload inputrc

#### Colored Prompts
Colored prompts accomplish several useful functions. 
- beautify the user's interface;
- visually distinguish important pieces of information in the user's environment from one another.
  - For example the current directory from the current user's name, so that reading the present working directory, `pwd`, becomes just finding a particular color the user has chosen in the prompt; and
- visually distinguish the root-shell-prompt from the user-shell-prompt

Do both:
```bash
$ echo "PS1='\[\e[4;33m\]\u\[\e[m\]\[\e[1;34m\]\w\[\e[m\]\[\e[1;32m\]\$\[\e[m\] \[\e[0;37m\]'" >> ~/.bashrc
$ su
# echo "PS1='\[\e[0;31m\]\u\[\e[m\]\[\e[1;34m\]\w\[\e[m\]\[\e[0;31m\]#\[\e[m\]\[\e[0;37m\] '" >> ~/.bashrc
```

Place wallpapers in ~/.wallpaper and randomize wallpaper prior to loading i3 with `~/.bin/wallpaper-setter-script.sh`:
```bash
#!sh
feh --bg-max --randomize ~/.wallpaper/* &
`https://github.com/wetlife/workstationCreation.git``
```

### Get 256 colors in terminal:
write a line in <readline.something> to set colors to 256. Also use any gui preference-editor in the chosen terminal emulator. Terminal settings don't allow setting 256 colors.

### Setup VIM:
echo good initial settings into ~/.vimrc:
```bash
$ echo 'syntax on
filetype plugin indent on
set number " enable line-numbering' >> ~/.vimrc
set bri
set showbreak=>>
set linebreak
```

Get the wombat256mod colorscheme by downloading wombat256mod.vim from
[http://www.vim.org/scripts/script.php?script_id=2465].

Shell:
```bash
mkdir -p ~/.vim/colors
curl http://www.vim.org/scripts/download_script.php?src_id=13400 > ~/.vim/wombat256mod.vim
echo 'colorscheme wombat256mod " set a nice colorscheme' >> ~/.vimrc
```

install the vim-airline plugin from the shell:
```bash
git clone https://github.com/bling/vim-airline ~/.vim/bundle/vim-airline
echo 'set laststatus=2' >> ~/.vimrc
```

## Use the Workflow.
### Manage windows with i3:
- let i3 generate its configuration file and use `alt` as the modifier-key(mod) when prompted;
- start a terminal emulator with `alt-enter`
  - make use of tab-completion in the terminal: start typing a command and press tab; if nothing happens press tab again to see all possible completions;
- run commands and start applications by pressing `alt-d` and then typing the command(make use of tab completion here);
- vertically tile new windows with `alt-v`;
- horizontally tile new windows with `alt-h`;
- move focus between windows in the current workspace by holding down `alt` while pressing either `j`, `k`, `l`, `;`, or any arrow-key(you rob i3 of its power by moving your hands off the homerow);
- move windows within the current workspace by holding down `alt-shift` while pressing either `j`, `k`, `l`, `;`, or any arrow-key(you rob i3 of its power by moving your hands off the homerow);
- change workspaces by holding down `alt-<NUMBER>`, where `<NUMBER>` is a number-key;
- move the current window to a workspace by holding down `alt-shift-<NUMBER>`, where `<NUMBER>` is a number-key;
- one can browse the Web on one workspace, email on a second workspace, and work on other workspaces
  - (it is nice to leave a set of windows open, do something else, and later instantly return to the original set of windows); and
- learn to use the keyboard rather than the mouse where possible and you'll experience great efficiency gains(before you know it, you will be the "wizard" who amazes others with flurries of wondrous keyboard-computing!)

### Use Git for Distributed Version Control of Text
Setup the minimal configuration info:
	- `git config --global user.name "John Doe"`
	- `git config --global user.email johndoe@example.com`
- Create global git ignore file 
  - `git config --global core.excludesfile ~/.gitignore_global
  - [`~/.gitignore_global`](git-workstation-config/.gitignore_global)
  - an example global ignore file that uses octocat's recommended miscelaneous-, tex-, and python-global-ignore files: `./config_files/.gitconfig_global`
- Create a local [`.gitignore`](git-workstation-config) within each repository if it is desired to ignore a repo-specific-set of files and directories

- configure git with the following commands(I added `--global` to original steps found here: http://www.rosipov.com/blog/use-vimdiff-as-git-mergetool/)
  - `git config --global merge.tool vimdiff`
  - `git config --global merge.conflictstyle diff3`
  - `git config --global mergetool.prompt false`
- `git status` reports the current status of all added files
- `git add foo` adds the current state of `foo` to this commit
- changing the contents of `foo` causes `git status` to report that there are changes to `foo` which haven't been added
- `git mergetool` to resolve merge conflicts with vim
	- use vim-commands like `:diffg[et] re[mote]` and `:diffp[ut] lo[cal]`
- commit with finest granularity practical
- commit-messages <72 chars wide with imperative voice for uniformity, conciseness, and clarity
- working in branches allows flexible workflows
  - suppose work is occurring in a branch on `FEATURE_FOO`
	- an immediate change is needed to the trunk
		- stash or commit changes to `FEATURE_FOO`,
		- checkout `master`,
		- create branch `PATCH` for the patch,
		- do needed patching,
		- `git add PATCHED_FILES` to have git track changes to `PATCHED_FILES`
		- `git commit` to commit changes to branch `PATCH`,
		- `git checkout master` to switch to the trunk,
		- `git merge PATCH`,
		- `git checkout FEATURE_FOO`,
		- `git rebase master` to rebase FEATURE_FOO onto master to absorb new changes to trunk,
		- resolve any conflicts from auto-merging,
		- finish work on `FEATURE_FOO`,
		- `git checkout master`,
		- `git merge FEATURE_FOO` to merge in completed `FEATURE_FOO` into trunk on top of `PATCH`,
		- resolve any conflicts from auto-mergings

### Write Technical Documents With $$\LaTeX$$ Like a Pro
A pleasing and efficient workflow to typeset technical documents is laid out beautifully
[here](http://dlpeterson.com/2013/08/latex-workflow/) by Dale Lukas Peterson.

### Setup Git
- Migrate settings via a file with the command `cp config-files/.gitconfig ~` .
- Set global git parameters from the command-line:
  - `$ git config --global user.name "NAME GOES HERE"`
  - `$ git config --global user.email "EMAIL GOES HERE"`

### commands:
- standard streams of text are standard input or stdin, standard output or stdout, and standard error or stderr
- most commands have usage of the form `commandName --flag argument`
- a leading `$` indicates that sh or bash are interpret the command
- `pwd` prints the present working directory;
- `cd <DIR>` changes the current directory;
- `echo "all these words"` prints out the string `all these words` to stdout;
- `cat` prints the contents of a text file;
- `head -n 5 oneFoo` prints the first 5 lines of file `oneFoo`;
- `tail -n 23 someFoo` prints the last 23 lines of text in file `someFoo`;
- use tab-completion to reduce unnecessary typing;
- know how to redirect and pipe output to create powerful command pipelines:
  - `|` composes commands by piping stdout of the left command into stdin of the right command:
   - `progFoo | progToo` pipes output from `progFoo` into `progToo`;
  - `>` redirects command output (overwrites existing files!):
   - `foo > someFile` redirects stdout from `foo` into file `someFile`
   - `foo 2> fooBooHoo` redirects errors from command `foo` into file `fooBooHoo`; and
   - `&> /p/a/t/h/someFile` redirects standard out and standard error to the file named `someFile` located at `/p/a/t/h/`;
  - `>>` appends redirected standard output to a file
   - `echo "appendage" >> someFile` appends a newline and the text `appendage` to the file named `someFile`.

### Write Technical Documents With $\LaTeX$ Like a Pro
My favorite workflow to typeset technical documents is laid out beautifully [here by Dale Lukas Peterson](http://dlpeterson.com/2013/08/latex-workflow/).   The previewed PDF is recompiled and the preview is updated when changes are saved to `file.tex`.
Executive Summary:
- $`latexmk -pvc -pdf <file.tex>`
- $`vim <file.tex>`

## use the keyboard
### Windows
- `<win>-<COMMAND>` executes COMMAND
- `<ctrl>-c` copies a selection
- `<ctrl>-x` copies then deletes a selection, which is commonly called "cut"-ing
- `<ctrl>-v` pastes
- `<ctrl>-f` finds text
- `<alt>-<tab> [-<tab>] [-<tab>] ...` switches applications
- `<ctrl>-<tab> [-<tab>] [-<tab>] ...` switches tabs
- `<ctrl>-w` closes a tab
- `<alt>-<F4>` closes an application
- `<win>-<NUMBER>` selects item number NUMBER from the taskbar
- `<ctrl>-<alt>-<delete>` opens a dialog to access task manager or logoff
- `<ctrl>-<shift>-<escape>` opens the task manager
- `<ctrl>-<left arrow>` moves the cursor a "word" to the left
- `<ctrl>-<right arrow>` moves the cursor a "word" to the right
- `<ctrl>-<shift>-<left arrow>` selects the "word" to the left
- `<ctrl>-<shift>-<right arrow>` selects the "word" to the right
- `<ctrl>-<delete>` and `<ctrl>-<backspace>` delete entire words at a time
- click in text, hold `<shift>`, and click a second time to select everything selectable between the two points clicked
  - this trick works in multi-selectable controls like drop-downs
- pressing `<ctrl>` while selecting several items allows one to select those individual items
- `<ctrl><win><arrow>` selects the workspace in the `<arrow>`-direction
- `<ctrl><shift><win><arrow>` moves the focused application to the workspace in the `<arrow>`-direction

### interface text with vi(m):
- composing commands is the power of this interface just as composing words is the power of a wordy language
- `i` enters insert mode
- `a` enters insert mode one position right of, or "after," the cursor's position
- `h`, `j`, `k`, and `l` move the cursor left, right, up, and down respectively while in normal mode
- `<escape>` or `<ctrl>-[` move the cursor one position to the left and enter normal mode; one is accessible from the home-row
- `/` searches
- `n` finds next
- `w` moves forward a word
- `b` moves backward a word
- `r` replaces a selection or any character under the cursor with something
- `s` substitutes an arbitrary string of text for the selection or the character under the cursor

### set resolution to half the size of hd 1080 in each dimension:
`xrandr -s 960x540`

### set brightness:
`xrandr --output eDP-1 --brightness .5`

### Use mplayer to effect picture-in-picture:
`mplayer tv:// -tv driver=v4l2:width=400:height=300 -vo picture-in-picture -geometry 100%:100% -noborder &> /tmp/picture-in-picture-`date +%Y.%m.%dat%H.%M.%S`.log`

## driving a web browser efficiently
- `<ctrl>-l` selects the address bar
- `<ctrl>-l`, `wikipedia`, then `<ctrl>-<enter>` goes to www.wikipedia.com.
- `<alt>-<left arrow>`, `<ctrl>-[`, or sometimes `<backspace>` goes back in history

### Use Vimium to Browse the Internet Efficiently
Vimium is a Firefox, Chrome, and chromium extension that provides a vim-like, homerow-driven interface to a graphical web-browser. Compose commands to program the browser as one programs an editor. Set the browser to scroll smoothly to ride a web of fluid text.
- composing commands is the interface as it is in vi(m)
- `j` down
- `k` up
- `l` right
- `h` left
- `f` follow links
- `/` search in page
- `y` yank
- `yy` yank current url
- `?` show help

#TODO
=====
- create a section for git
- introduce pmount and the utility of mounting without either an entry in /etc/fstab or sudo

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
interface a keyboard,
keyboard shortcuts,
keyboard navigation,
driving a computer from the keyboard,

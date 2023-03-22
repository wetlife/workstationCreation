#!/bin/bash
# Configure a workstation with optional input from a user
#TODO setup gcloud
#TODO turn off keyboard's backlight

# get directory containing script for robust relative addressing
SCRIPT_DIR="$(  cd "$( dirname "${BASH_SOURCE[0]}" )" 2>&1 >/dev/null && pwd cd "$( dirname "${BASH_SOURCE[0]}" )" 2>&1 >/dev/null && pwd )"
echo "\$SCRIPT_DIR: $SCRIPT_DIR"

#####################################################################
# ask to ASK, ACT, and VERIFY success or fail                       #
#     USAGE: ask_act_verify ACT VERIFY                              #
#     parameter act: act realizes the desired state                 #
#     parameter verify: verify desired state against a truthy value #
#     TODO FIXME this function has not been tested to work          #
#####################################################################
ask_act_verify ()
{
	act=$1
	verify=$2
	echo 'act:'; echo $act
	echo 'verify:'; echo $verify; echo
	if $($verify) # idempotence: falsey return-value indicates act isn't done, though `if command` succeeds with successful command
	then
		echo
		if [[ ! $REPLY =~ ^[yY]$ ]] # proceed w/ y from user
		then
			echo "# aborting act $act"
			return 1
		else
			$act
		fi
		if [ ! $verify ] # act is done => `verify` is truthy
		then
			echo "#SUCCESS: $act"
		else
			echo \# failed to verify action is done after act:
			echo \# act that did not verify: $act
			echo \# verify which failed: $verify
		fi
	fi
}

# USAGE: copy_all_files <source> <destination>
copy_all_files ()
{
	for FILE in $(ls -a $SOURCE)
	do
		if [[ $FILE =~ ^.$ ]] || [[ $FILE =~ ^..$ ]]
			then continue
		fi
		echo $FILE will be copied to $DESTINATION
	done
}

# USAGE: does_file_contain_string <file> <string>
does_file_contain_string () {
	grep -Fq $1 $2
}

echo "
###############################################
# rsync configuration-files into their \$HOME #
###############################################
"
RSYNC_CMD="rsync -vurt $SCRIPT_DIR/config-files/user/ $HOME"
echo preview files to be synchronized:
rsync -vurtn $SCRIPT_DIR/config-files/user/ ~/
read -p "$RSYNC_CMD?(y is yes, q quits, and anything else skips)" -n 1 -r
echo
if [[ $REPLY =~ ^[qQ]$ ]]
then
    exit 0
elif [[ $REPLY =~ ^[yY]$ ]]
then
	echo executing $RSYNC_CMD':'
    $($RSYNC_CMD)
else
    echo configuration-files not updated
fi
echo

#################
# rsync scripts #
#################
RSYNC_CMD="rsync -vurt $SCRIPT_DIR/scripts/ $HOME/bin"
echo files to be synchronized:
rsync -vurtn $SCRIPT_DIR/scripts/ $HOME/bin
read -p "$RSYNC_CMD?(y is yes, q quits, and anything else skips)" -n 1 -r
echo
if [[ $REPLY =~ ^[qQ]$ ]]
then
    exit 0
elif [[ $REPLY =~ ^[yY]$ ]]
then
	echo $RSYNC_CMD':'
	$RSYNC_CMD
else
    echo scripts not updated
fi
echo

###################################
## editing-mode and keymap get vi #
###################################
#READLINE_CONFIG_STRING1='set editing-mode vi'
#READLINE_CONFIG_STRING2='set keymap vi'
#CURRENT_DOTFILE='.inputrc'

## function of variables
#ask_act_verify "$READLINE_CONFIG_STRING1 >> ~/$CURRENT_DOTFILE"
#ask_act_verify "$READLINE_CONFIG_STRING2 >> ~/$CURRENT_DOTFILE"

## function of literals
#ask_act_verify\
#	'echo set editing-mode vi >> ~/.inputrc'\
#	'grep -Fqs set editing-mode vi ~/.inputrc'
#ask_act_verify\
#	'echo set keymap vi >> ~/.inputrc'\
#	'grep set keymap vi ~/.inputrc'

## code manually with literals
## TODO replace literal values with variables
#if grep -Fqs 'set editing-mode vi' ~/.inputrc
#then
#	echo ~/.inputrc contains '"set editing-mode vi"'
#else
#	read -p 'echo set editing-mode vi >> ~/.inputrc? ' -n 1 -r
#	echo
#	if [[ $REPLY =~ ^[yY]$ ]]
#	then
#		echo 'set editing-mode vi' >> ~/.inputrc
#		echo tail of ~/.inputrc:; echo
#		tail ~/.inputrc; echo
#	fi
#fi
#if grep -Fqs 'set keymap vi' ~/.inputrc
#then
#	echo ~/.inputrc contains '"set keymap vi"'
#else
#	read -p 'echo set keymap vi >> ~/.inputrc? ' -n 1 -r
#	echo
#	if [[ $REPLY =~ ^[yY]$ ]]
#	then
#		echo 'set keymap vi' >> ~/.inputrc
#		echo tail of ~/.inputrc:; echo
#		tail ~/.inputrc; echo
#	fi
#fi

# code manually with literals
if grep -Fqs 'set editing-mode vi' ~/.inputrc
then
	echo ~/.inputrc contains '"set editing-mode vi"'
else
    read -p 'echo set editing-mode vi >> ~/.inputrc?(y, q, or /.*/ to skip)' -n 1 -r
	echo
	if [[ $REPLY =~ ^[qQ]$ ]]
	then
        exit 0
    elif [[ $REPLY =~ ^[yY]$ ]]
    then
		echo 'set editing-mode vi' >> ~/.inputrc
		echo tail of ~/.inputrc:; echo
		tail ~/.inputrc; echo
	fi
fi
echo

if grep -Fqs 'set keymap vi' ~/.inputrc
then
	echo ~/.inputrc contains '"set keymap vi"'
else
	read -p 'echo set keymap vi >> ~/.inputrc?(y, q, or /.*/ to skip)' -n 1 -r
	echo
	if [[ $REPLY =~ ^[yY]$ ]]
	then
		echo 'set keymap vi' >> ~/.inputrc
		echo tail of ~/.inputrc:; echo
		tail ~/.inputrc; echo
	fi
fi
echo

if grep -Fqs 'set show-mode-in-prompt on' ~/.inputrc
then
	echo ~/.inputrc contains '"set show-mode-in-prompt on"'
else
	read -p 'echo set show-mode-in-prompt on >> ~/.inputrc?(y, q, or /.*/ to skip)' -n 1 -r
	echo
	if [[ $REPLY =~ ^[yY]$ ]]
	then
		echo 'set show-mode-in-prompt on' >> ~/.inputrc
		echo tail of ~/.inputrc:; echo
		tail ~/.inputrc; echo
	fi
fi
echo

#####################################################
## set default editor for readline and various apps #
#####################################################
VISUAL_GETS_VIM="VISUAL=vim"
#ask_act_verify(VISUAL_GETS_VIM, "grep -F 'VISUAL=' ~/.bashrc")
if grep -Fsq $VISUAL_GETS_VIM ~/.bashrc
then
	echo ~/.bashrc contains '"'$VISUAL_GETS_VIM'"'
else
	read -p "echo export $VISUAL_GETS_VIM >> ~/.bashrc?(y, q, or /.*/ to skip)" -n 1 -r
	echo
	if [[ $REPLY =~ ^[qQ]$ ]]
	then
        exit 0
    elif [[ $REPLY =~ ^[yY]$ ]]
    then
		echo >> ~/.bashrc
		echo "# set VISUAL as preferred specification of editor" >> ~/.bashrc
		echo export $VISUAL_GETS_VIM >> ~/.bashrc
		echo tail -2 of ~/.bashrc:
		tail -2 ~/.bashrc
	fi
fi
echo

############################################
# EDITOR is used by git and perhaps others #
############################################
EDITOR_GETS_VIM="EDITOR="
#ask_act_verify(EDITOR_GETS_VIM, "grep -F 'VISUAL=' ~/.bashrc")
if grep -Fsq $EDITOR_GETS_VIM ~/.bashrc
then
	echo ~/.bashrc contains '"'$EDITOR_GETS_VIM'"'
else
	read -p "echo $EDITOR_GETS_VIM >> ~/.bashrc?(y, q, or /.*/ to skip)" -n 1 -r
	echo
	if [[ $REPLY =~ ^[qQ]$ ]]
	then
        exit 0
    elif [[ $REPLY =~ ^[yY]$ ]]
    then
		echo >> ~/.bashrc
		echo "# set EDITOR for git and perhaps other apps" >> ~/.bashrc
		echo "export "$EDITOR_GETS_VIM'$VISUAL' >> ~/.bashrc
		echo tail -2 of ~/.bashrc:
		tail -2 ~/.bashrc
	fi
fi
echo

##################
## configure git #
##################
read -p "configure git?(y, q, or /.*/ to skip)" -n 1 -r
echo
if [[ $REPLY =~ ^[qQ]$ ]]
then
    exit 0
elif [[ $REPLY =~ ^[yY]$ ]]
then
	read -p "Replace all lines in user.name with the supplied name?(y, q, or /.*/ to skip)" -n 1 -r
	echo
	if [[ $REPLY =~ ^[qQ]$ ]]
	then
        exit 0
    elif [[ $REPLY =~ ^[yY]$ ]]
    then
		REPLACEMENT_OPT='--replace-all'
	else
		REPLACEMENT_OPT='--add'
	fi
	read -p 'git username: '
	echo
	git config --global $REPLACEMENT_OPT user.name "$REPLY"
	echo git username is $(git config --get-all user.name)
	read -p 'git email address: '
	echo
	git config --global user.email $REPLY
	echo git email is $(git config --get-all user.email)
fi
echo


#########################
# append GOPATH to PATH #
#########################
read -p 'Append GOPATH to PATH in ~/.bashrc?(y, q, or /.*/ to skip)' -n 1 -r
echo
if [[ $REPLY =~ ^[qQ]$ ]]
then
    exit 0
elif [[ $REPLY =~ ^[yY]$ ]]
then
	echo 'export PATH="$PATH:$HOME/go/bin"' >> ~/.bashrc
fi
echo

############################
#### SUDO REQUIRED BELOW ###
############################
############################
############################

#################################################
### install typewriter-font used in i3's config #
#################################################
read -p "Install typewriter-font  required by i3's config? (y, q, or /.*/ to skip)\n" -n 1 -r
echo
if [[ $REPLY =~ ^[qQ]$ ]]
then
    exit 0
elif [[ $REPLY =~ ^[yY]$ ]]
then
	FONTNAME="SpecialElite.ttf"
	FONT_INSTALL_DIR="/usr/share/fonts/truetype/specialelite/"
	echo "Downloading and installing font $FONT_INSTALL_DIR$FONTNAME."
	mkdir /tmp/specialelite
	cd /tmp/specialelite
	curl https://fonts.google.com/download?family=Special%20Elite -o ./specialelite.zip
	unzip specialelite.zip
	sudo mkdir $FONT_INSTALL_DIR
	sudo mv ./* $FONT_INSTALL_DIR
	sudo cp "${FONT_INSTALL_DIR}SpecialElite"{-Regular,}.ttf
	echo "Contents of $FONT_INSTALL_DIR:"
	ls $FONT_INSTALL_DIR
else
	echo "SKIPPED: download and install font SpecialElite-Regular.ttf **required by this system's automatically installed config for i3** "
fi
echo

#######################################################################
# add apt repo from devs and install i3 v>=4.22 for i3 gaps in config #
#######################################################################
read -p "Add apt repo from i3's developers and install i3 v>=4.22 for i3 gaps, which is required in i3's config line \`gaps inner\`, as documented in the file's comments? (y, q, or /.*/ to skip)\n" -n 1 -r
echo
if [[ $REPLY =~ ^[qQ]$ ]]
then
    exit 0
elif [[ $REPLY =~ ^[yY]$ ]]
then
	echo 'Attempting to add apt repo and download the latest stable i3.'
	echo 'Refer to https://i3wm.org/docs/repositories.html on error.'
	/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
	sudo apt install ./keyring.deb
	echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | sudo tee /etc/apt/sources.list.d/sur5r-i3.list
	sudo apt update
	sudo apt install i3
	echo
else
	echo "SKIPPED: add apt repo and download the latest stable i3"
	echo "WARNING: if i3 version is <v4.22 then its config will err."
	i3 --version
fi
echo

##########################################################################
# set catppuccin-frappe as the colorscheme for qterminal and other tools #
##########################################################################
read -p 'Setup cattpuccin-frappe as colorsheme for qterminal? (y, q, or /.*/ to skip)' -n 1 -r
echo
if [[ $REPLY =~ ^[qQ]$ ]]
then
    exit 0
elif [[ $REPLY =~ ^[yY]$ ]]
then
	git clone https://github.com/catppuccin/qterminal catppuccin-qterminal 
	sudo cp src/Catppuccin-* /usr/share/qtermwidget5/color-schemes/
	echo 'NOTICE: now restart qterminal and select the colorscheme "catppuccin-frappe"'
	echo
fi
echo

####################################################
# configure synaptics for decent touchpad-behavior #
####################################################
# TODO ensure this makes the touchpad usable
read -p 'sudo cp '$SCRIPT_DIR'/config-files/root/etc/X11/Xsession.d/80synaptics /etc/X11/Xsession.d/?(y, q, or /.*/ to skip)' -n 1 -r
echo
if [[ $REPLY =~ ^[qQ]$ ]]
then
    exit 0
elif [[ $REPLY =~ ^[yY]$ ]]
then
	if [ ! -d /etc/X11/Xsession.d ]
	then
		echo sudo mkdir -p /etc/X11/Xsession.d
		sudo mkdir -p /etc/X11/Xsession.d
	fi
echo sudo cp $SCRIPT_DIR/config-files/root/etc/X11/Xsession.d/80synaptics /etc/X11/Xsession.d/
sudo cp $SCRIPT_DIR/config-files/root/etc/X11/Xsession.d/80synaptics /etc/X11/Xsession.d/
fi
echo

###############################
# download and install vscode #
###############################
read -p 'Install vscode?(y, q, or /.*/ to skip)' -n 1 -r
echo
if [[ $REPLY =~ ^[qQ]$ ]]
then
    exit 0
elif [[ $REPLY =~ ^[yY]$ ]]
then
	echo '######## Outline of Installation of vscode #########################'
	echo ' 1. Download code.deb from https://code.visualstudio.com/download. #'
	echo ' 2. Run `sudo dpkg -i ~/Downloads/codeX.XX.deb`.                   #'
	echo ' 3. Run `sudo apt-get install -f` but nothing should need fixed,  #'
	echo '###################################################################'
fi
echo

##################################
## install applications with apt #
##################################
read -p 'apt update and install software after approving or specifying a list of software?(y, q, or /.*/ to skip)' -n 1 -r
echo
if [[ $REPLY =~ ^[yY]$ ]]
then
	SOFTWARE_LIST='alttab gccgo-go i3 latexmk picom texlive texlive-publishers texlive-science texlive-music trash-cli zathura'
	echo Software to be installed: $SOFTWARE_LIST.
    read -p 'Enter custom list or append to list of software to install?(c(ustom), a(ppend), q(uit), or /.*/ to skip)' -n 1 -r
	echo
	if [[ $REPLY =~ ^[qQ]$ ]]
	then
        exit 0
    elif [[ $REPLY =~ ^[cC]$ ]]
    then
		read -p 'Enter list of software to install:' -r
		echo
		SOFTWARE_LIST=$REPLY
    elif [[ $REPLY =~ ^[aA]$ ]]
    then
		read -p 'Enter list of software to append:' -r
		echo
		SOFTWARE_LIST=$SOFTWARE_LIST" "$REPLY
	fi
	echo sudo apt update
	sudo apt update
	echo sudo apt install $SOFTWARE_LIST
	sudo apt install $SOFTWARE_LIST
fi
echo

############################
## install gcloud with apt #
############################
read -p 'Install gcloud with apt, use a browser to sign in with google, and configure gcloud?(y, q, or /.*/ to skip)' -n 1 -r
echo
if [[ $REPLY =~ ^[qQ]$ ]]
then
    exit 0
elif [[ $REPLY =~ ^[yY]$ ]]
then
	echo Installing gcloud with apt:
	echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
	sudo apt-get install apt-transport-https ca-certificates
	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
	sudo apt-get update && sudo apt-get install google-cloud-sdk
	gcloud init
fi
echo

##########################
## install r and rstudio #
##########################
read -p 'Install r, install rstudio, add current user to group staff to let rstudio install packages to /usr/local/lib/R/?(y, q, or /.*/ to skip)' -n 1 -r
echo
if [[ $REPLY =~ ^[yY]$ ]]
then
	echo Instructions for this procedure are from url
	echo https://askubuntu.com/questions/919275/installing-rstudio-is-this-very-different-from-other-packages#answer-919288
	echo
	echo Installing r-base, r-base-dev, and their dependencies with apt:
	sudo apt-get install r-base r-base-dev
	echo Prefer installing r-packages with '`sudo apt install r-cran-<package>`'.
	echo
	echo Manual steps:
	echo 1. Go to https://www.rstudio.com/products/rstudio/#Desktop and download the rstudio .deb file.
	echo '2. Run `dpkg -i <path/to/rstudio-X.Y.Z-amd64.deb> && sudo apt install -f`.'
	read -p '3. Press y to add the current user to group staff so that rstudio may install packages to /usr/local/lib/R/.' -n 1 -r
	if [[ $REPLY =~ ^[yY]$ ]]
	then
		sudo adduser $USER staff
	fi
fi
echo

## TODO #####################################################
### ensure ~/bin in PATH (consider symlink to ~/.local/bin) #
#############################################################

## TODO ########################################
### install trash-cli with apt and override rm #
################################################

## TODO #################################################################
### get peepshower (proj of gradient_box), make wallpapers, and install #
#########################################################################

## TODO ############################################################
### install snaps from current machine and quickly search for more #
####################################################################

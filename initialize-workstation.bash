#!/bin/bash
# Configure a workstation with optional input from a user
#TODO setup gcloud TODO turn off keyboard's backlight

# get directory containing script for robust relative addressing
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "\$SCRIPT_DIR: $SCRIPT_DIR"

##########################################################
# ask to ACT, ACT, and VERIFY success or fail            #
#     USAGE: ask_act_verify ACT VERIFY                   #
#     arg act: act realizes the desired state            #
#     arg verify: verify desired state with truthy value #
##########################################################
ask_act_verify ()
{
	act=$1
	verify=$2
	echo 'act:'; echo $act
	echo 'verify:'; echo $verify; echo
	if $($verify) # idempotence: falsey return-value indicates act isn't done, though `if command` succeeds with successful command
	then
		read -p "# $act? Input y or Y to proceed. " -n 1 -r
		echo
		if [[ ! $REPLY =~ ^[Yy]$ ]] # proceed w/ y from user
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

##############################################
# rsync configuration-files into their $HOME #
##############################################
RSYNC_CMD="rsync -vurt $SCRIPT_DIR/config-files/user/ $HOME"
echo files to be synchronized:
rsync -vurtn $SCRIPT_DIR/config-files/user/ ~/
read -p "$RSYNC_CMD? " -n 1 -r
echo
if [[ $REPLY =~ ^[yY]$ ]]
then
	echo $RSYNC_CMD':'
	$RSYNC_CMD
fi

#################
# rsync scripts #
#################
if [ ! -d ~/.bin ]; then
	echo mkdir -p ~/.bin
	mkdir -p ~/.bin
fi

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
	read -p 'echo set editing-mode vi >> ~/.inputrc? ' -n 1 -r
	echo
	if [[ $REPLY =~ ^[yY]$ ]]
	then
		echo 'set editing-mode vi' >> ~/.inputrc
		echo tail of ~/.inputrc:; echo
		tail ~/.inputrc; echo
	fi
fi
if grep -Fqs 'set keymap vi' ~/.inputrc
then
	echo ~/.inputrc contains '"set keymap vi"'
else
	read -p 'echo set keymap vi >> ~/.inputrc? ' -n 1 -r
	echo
	if [[ $REPLY =~ ^[yY]$ ]]
	then
		echo 'set keymap vi' >> ~/.inputrc
		echo tail of ~/.inputrc:; echo
		tail ~/.inputrc; echo
	fi
fi

#####################################################
## set default editor for readline and various apps #
#####################################################
VISUAL_GETS_VIM="VISUAL=vim"
#ask_act_verify(VISUAL_GETS_VIM, "grep -F 'VISUAL=' ~/.bashrc")
if grep -Fsq $VISUAL_GETS_VIM ~/.bashrc
then
	echo ~/.bashrc contains '"'$VISUAL_GETS_VIM'"'
else
	read -p "echo $VISUAL_GETS_VIM >> ~/.bashrc?" -n 1 -r
	echo
	if [[ $REPLY =~ ^[yY]$ ]]
	then
		echo $VISUAL_GETS_VIM >> ~/.bashrc
		echo tail of ~/.bashrc:
		echo
		tail ~/.bashrc
	fi
fi

##################
## configure git #
##################
read -p "configure git? " -n 1 -r
echo
if [[ $REPLY =~ ^[yY]$ ]]
then
	read -p "Replace all lines in user.name with the supplied name?" -n 1 -r
	echo
	if [[ $REPLY =~ ^[yY]$ ]]
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

############################
#### SUDO REQUIRED BELOW ###
############################
############################
############################

####################################################
# configure synaptics for decent touchpad-behavior #
####################################################
# TODO ensure this makes the touchpad usable
read -p 'sudo cp '$SCRIPT_DIR'/config-files/root/etc/X11/Xsession.d/80synaptics /etc/X11/Xsession.d/?' -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	if [ ! -d /etc/X11/Xsession.d ]
	then
		echo sudo mkdir -p /etc/X11/Xsession.d
		sudo mkdir -p /etc/X11/Xsession.d
	fi
echo sudo cp $SCRIPT_DIR/config-files/root/etc/X11/Xsession.d/80synaptics /etc/X11/Xsession.d/
sudo cp $SCRIPT_DIR/config-files/root/etc/X11/Xsession.d/80synaptics /etc/X11/Xsession.d/
fi

###############################
# download and install vscode #
###############################
read -p 'Install vscode?' -n 1 -r
echo
if [[ $REPLY =~ ^[yY]$ ]]
then
	echo '######## Outline of Installation of vscode #########################'
	echo ' 1. Download code.deb from https://code.visualstudio.com/download. #'
	echo ' 2. Run `sudo dpkg -i ~/Downloads/codeX.XX.deb`.                   #'
	echo ' 3. Run `sudo apt-get install -f` but nothing should need fixed,  #'
	echo '###################################################################'
fi

##################################
## install applications with apt #
##################################
read -p 'apt update and install software?' -n 1 -r
echo
if [[ $REPLY =~ ^[yY]$ ]]
then
	SOFTWARE_LIST='i3 gccgo-go latexmk texlive{,-publishers,-science,-music} zathura'
	echo Software to be installed: $SOFTWARE_LIST.
	read -p 'Enter custom list of software to install?' -n 1 -r
	echo
	if [[ $REPLY =~ ^[yY]$ ]]
	then
		read -p 'Enter list of software to install:' -n 1 -r
		echo
		SOFTWARE_LIST=$REPLY
	fi
	echo sudo apt update
	sudo apt update
	echo sudo apt install $SOFTWARE_LIST
	sudo apt install $SOFTWARE_LIST
fi

#########################
## ensure ~/bin in PATH # TODO
#########################

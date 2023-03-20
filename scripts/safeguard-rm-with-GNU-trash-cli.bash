#!/bin/bash
# This script overrides rm with a script named rm that runs
#  trash-put so that files are moved and timestamped rather
#  than destroyed

# get directory containing script for robust relative addressing
SCRIPT_DIR="$(  cd "$( dirname "${BASH_SOURCE[0]}" )" 2>&1 >/dev/null && pwd cd "$( dirname "${BASH_SOURCE[0]}" )" 2>&1 >/dev/null && pwd )"
echo "\$SCRIPT_DIR: $SCRIPT_DIR"

sudo apt install trash-cli
cp $SCRIPT_DIR/rm ~/.local/bin/
chmod +x ~/.local/bin/rm
if [[ ~/.local/bin/rm -eq `which rm` ] && [ -E ~/.local/bin/rm ]]
then
	echo "rm appears to be successfully protected"
else
	echo "rm is not protected:"
	echo "which -a rm:"
	which -a rm
	echo "ls -l \`which rm\`:"
	ls -l `which rm`
fi

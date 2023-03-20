if [[ $(( $RANDOM % 2 )) -eq 1 ]]
then
	feh --bg-max --randomize --no-xinerama ~/.local/src/gradient_box/graded-wallpapers/*
else
	feh --bg-max --randomize ~/.local/src/gradient_box/graded-wallpapers/*
fi

# usage: gcreate user repo "description if supplied"
gcreate ()
{
	if [[ $1 = --help ]]
	then
		echo usage: gcreate user repo '"description if supplied"'
		exit
	fi
	curl -u $1 https://api.github.com/user/repos -d "{\"name\": \"$2\", \"description\": \"$3\"}"
}
gcreate $@

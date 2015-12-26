# https://gist.github.com/azu/09dd6f27f52e2e8d9978
mkdev () {
	if [ ! -n "$1" ]
	then
		echo "Usage: mkdev dir-name"
		return
	fi
	local dirName=$1
	local rootDir=$(ghq root)
	local githubUser="github.com/$(git config user.name)"
	if [[ dirName = */* ]]
	then
		githubUser = "github.com"
	fi
	local devPath="${rootDir}/${githubUser}/${dirName}"
	mkdir -p ${devPath}
	cd ${devPath}
}

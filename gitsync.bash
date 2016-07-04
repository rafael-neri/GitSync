#GitSync
#Sync all Git repositories in a given directory of repositories
#GitSync is licensed under the GNU GPL v3

VERSION=0.0.3

function out #Output to screen (optional) and log to file
{

	msg=$1
	silent=$2
	if [ $silent == false ]
	then
		echo $msg
	fi
	if [ $logFile != "NONE" ]
	then
		echo $msg >> $logFile
	fi

}

function removeOldLogFile #Remove old log file
{

	if [ -f $logFile ]
	then
		rm $logFile
	fi

}

function boilerLog #Append welcome message to log file
{

	out "GitSync v$VERSION" "true"
	out "Written by: Tristan B. Kildaire (Deavmi)" "true"
	out "Licensed under the GNU GPL v3" "true"
	out "Source Code: https://github.com/deavmi/GitSync" "true"
	out "----------------------------------------------" "true"
	out "" "true"

}

function getRepoCount #Get number of repositories
{

	count=0
	for repo in $(ls $repoDir)
	do
		if [ -d $repo ]
		then
			count=$(($count+1))
		fi
	done

	echo $count

}

function syncRepos #Sync repositories
{

	if [ $logFile != "NONE" ]
	then
		removeOldLogFile
		boilerLog
	fi

	repos=$(getRepoCount)
	out "Number of repositories: $repos" "false"
	out "Repository directory: $repoDir" "false"
	if [ "$logFile" != "NONE" ]
	then
		out "Logging to file: $logFile" "false"
	else
		out "Logging to file disabled" "false"
	fi
	out "" "false"
	out "Start time: $(date)" "false"
	out "" "false"
	out "Syncing repositories..." "false"
	cd "$repoDir"
	count=0
	for repo in $(ls $repoDir)
	do
		if [ -d $repo ]
		then
			count=$(($count+1))
			out "Syncing repository '$repo'... [$count/$repos]" "false"
			cd $repo
			git pull
			cd ..
		fi
	done
	out "Repositories have been synced." "false"
	out "" "false"
	out "End time: $(date)" "false"
	out "" "false"

}

function checkConf #Make sure configuration file contains all required variables
{

	if [ "$repoDir" == "" ]
	then
		echo "Configuration variable 'repoDir' not found or empty."
		exit 2
	else
		if [ ! -d $repoDir ]
		then
			echo "repoDir '$repoDir' does not exist."
			exit 3
		fi
	fi

	if [ "$logFile" == "" ]
	then
		echo "Configuration variable 'logFile' not found or empty."
		exit 2
	fi

}

function hi #Boilerplate stuff
{

	clear
	echo "GitSync v$VERSION"
	echo "Written by: Tristan B. Kildaire (Deavmi)"
	echo "Licensed under the GNU GPL v3"
	echo "Source Code: https://github.com/deavmi/GitSync"
	echo -e "----------------------------------------------\n"
	sleep 0.5

}

function init #Check for config, if exists then check conf and if good - sync repos
{

	if [ $# == 0 ]
	then
		echo "No configuration file specified."
	elif [ $# == 1 ]
	then
		if [ -f "$1" ]
		then
			source "$1"
			checkConf
			syncRepos
		else
			echo "Configuration file '$1' not found."
			exit 1
		fi
	else
		echo "Too many arguments."
	fi

}

hi
init $@

#!/usr/bin/env bash

#Vim Pack Plugin management w/ git submodules

vPluginsDir="pack/plugins"
vStartDir="start"
vOptDir="opt"
vUrlRegexp="https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)"

fUsage(){
	echo "${0##*/} <add|remove|backup|list|status|update|summary>"
}

fList(){	
	grep 'url\|path' .gitmodules | cut -d " " -f3 | awk 'NR%2{printf "%s\t=>\t",$0;next;}1' | column -t
}

fStatus(){
	git submodule status
}

fSummary(){
	git submodule summary
}

fUpdate(){
	git submodule sync
	git submodule update --remote --merge
	git commit -am "Update Modules"
}

fAdd(){
	[[ -z "$1" ]] && { 
		echo "Usage ${0##*/} add <url> [modulename] [opt]";
		exit 1;
	}
	[[ ! "$1" =~ $vUrlRegexp ]] && { 
		echo "$1 is not a valid url"; 
		exit 1; 
	}
	vModuleUrl=$1
	[[ -n "$3" && -z "$2" ]] && { vInstallDir="$vPluginsDir/$vOptDir/${vModuleUrl##*/}"; }
	[[ -n "$3" && -n "$2" ]] && { vInstallDir="$vPluginsDir/$vOptDir/$2"; }
	[[ -z "$3" && -n "$2" ]] && { vInstallDir="$vPluginsDir/$vStartDir/$2"; }
	[[ -z "$3" && -z "$2" ]] && { vInstallDir="$vPluginsDir/$vStartDir/${vModuleUrl##*/}"; }

	fAddModule "$vModuleUrl" "$vInstallDir"
	exit 0
}

fRemove(){
	[[ -z "$1" ]] && { 
		echo "Usage ${0##*/} remove <modulename> <-f>";
		exit 1;
	}
	vRemovedPluginPath=$(find $vPluginsDir -type d -name "*$1*" |head -n1)
	[[ -n "$vRemovedPluginPath" && -f "$vRemovedPluginPath/.git" ]] && {	
		[[ -z "$2" ]] && {
			read -r -p "Are you sure you want to remove $vRemovedPluginPath ? [y/N] " response
			case "$response" in
    				[yY][eE][sS]|[yY]) fRemoveModule "$1" "$vRemovedPluginPath" ;;
    				*) exit 0; ;;
			esac;
		}
		[[ -n "$2" && "$2" == "-f" ]] && { fRemoveModule "$1" "$vRemovedPluginPath"; }
	}
	echo "unable to find module $1"
	exit 1
}

fAddModule(){
	echo "Installing $1 module in $2 path :"
	git submodule add "$1" "$2"; 
	git commit -m "Added $1 module"
	exit 0
}


fRemoveModule(){
	echo "Removing $1 module in $2 path :"
	git submodule deinit "$2"
	git rm -rf "$2"
	rm -rf .git/modules/"$2"
	git commit -m "Removed $1 modules"
	exit 0
}

case "$1" in 
	add) 		fAdd "$2" "$3" "$4"; 	;;
	remove) 	fRemove "$2" "$3"; 	;;
	list)		fList; 			;;
	status)		fStatus; 		;;
	update) 	fUpdate; 		;;
	summary)	fSummary 		;;
	*) 		fUsage; 		;;
esac

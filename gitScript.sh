#!/bin/bash	

	source ~/BashUtils.sh
	

	declare -a _args=("$@")

	BashUtils_decodeDashDashArguments _args
	BashUtils_echoBashSignature "###" $0 _args


	gitProject_="${_args[0]}"
	gitCmd_="${_args[1]}"
	gitMode_="${_args[2]}"


	bashParmRead=false
	
	if [[ -z "$gitProject_" ]]; then
		
		# Display eligable projects (files matching 'gitScript_*.sh') ...
	    echo ""
		n=1
		for file in "gitScript_"*".sh"; do
			printf "[%d] %s\n" $n "$file"  |  sed "s/gitScript_//"  |  sed "s/\.sh//"
			((n++))
		done
	    read  -p "Project []? "  gitProject
		bashParmRead=true
	
		# Decode project selected ...
    	n=1
		for file in "gitScript_"*".sh"; do
		    if [[ $gitProject -eq $n ]]; then gitProject_=`printf "%s" "$file"  |  sed "s/gitScript_//"  |  sed "s/\.sh//"`; fi
		    ((n++))
        done
	fi


	if [[ -n "$gitProject_" ]]; then

		if [[ -z "$gitCmd_" ]]; then
		
			gitCmd_Default="M"
			
			echo ""
			echo "[M] Merge"
			echo "[S] Stage"
			echo "[D] Deploy"
			read -p "Command [$gitCmd_Default]: " gitCmd
			bashParmRead=true
		
			if [[ -z "$gitCmd" ]]; then gitCmd="$gitCmd_Default"; fi
			if [[ "${gitCmd^^}" == "M" ]]; then gitCmd_="MERGE"; fi
			if [[ "${gitCmd^^}" == "S" ]]; then gitCmd_="STAGE"; fi
			if [[ "${gitCmd^^}" == "D" ]]; then gitCmd_="DEPLOY"; fi
		fi
			
		
		if [[ -z "$gitMode_" ]]; then
		
			gitMode_Default="P"
			
			echo ""
			echo "[P] Purge"
			echo "[O] Overwrite"
			read -p "Mode [$gitMode_Default]: " gitMode
			bashParmRead=true
		
			if [[ -z "$gitMode" ]]; then gitMode="$gitMode_Default"; fi
			if [[ "${gitMode^^}" == "P" ]]; then gitMode_="PURGE"; fi
			if [[ "${gitMode^^}" == "O" ]]; then gitMode_="OVERWRITE"; fi
		fi

		if [[ bashParmRead ]]; then  echo "";  fi

			
		if [[ -n "$BashUtils__tr" ]]; then echo "   >gitScript_$gitProject_.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$bashTrace"; fi
		bash "gitScript_$gitProject_.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$bashTrace"
	fi


	echo "done."

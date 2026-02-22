#!/bin/bash	
	
	
	#echo "<0[$0] 1[$1] 2[$2]"
	
	gitProject_="$1"
	gitCmd_="$2"
	gitMode_="$3"
	
	
	if [[ -z "$gitProject_" ]]; then
		
	    echo ""
		n=1
		for file in "gitScript_"*".sh"; do
			printf "[%d] %s\n" $n "$file"  |  sed "s/gitScript_//"  |  sed "s/\.sh//"
			((n++))
		done
	    read  -p "Project []? "  gitProject
	
    	n=1
		for file in "gitScript_"*".sh"; do
		    if [[ $gitProject -eq $n ]]; then gitProject_=`printf "%s" "$file" | sed "s/gitScript_//" | sed "s/\.sh//"`; fi
		    ((n++))
        done
	fi

	
	if [[ -z "$gitCmd_" ]]; then
	
	    gitCmd_Default="M"
		
	    echo ""
	    echo "[M] Merge"
	    echo "[S] Stage"
	    echo "[D] Deploy"
	    read -p "Command [$gitCmd_Default]: " gitCmd
	
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
	
    	if [[ -z "$gitMode" ]]; then gitMode="$gitMode_Default"; fi
    	if [[ "${gitMode^^}" == "P" ]]; then gitMode_="PURGE"; fi
    	if [[ "${gitMode^^}" == "O" ]]; then gitMode_="OVERWRITE"; fi
	fi

	
	#echo ">gitScript_$gitProject_.sh" "$gitProject_" "$gitCmd_" "$gitMode_"
	bash "gitScript_$gitProject_.sh" "$gitProject_" "$gitCmd_" "$gitMode_"

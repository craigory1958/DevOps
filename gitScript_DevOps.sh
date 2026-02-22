#!/bin/bash
 
 
 	#echo "<0[$0] 1[$1] 2[$2] 3[$3]"
	
	gitProject_="$1"
	gitCmd_="$2"
	gitMode_="$3"
		
	gitProjectRoot_="/home/craigory1958/_cwg-base"


    if [[ "$gitProject_" != "DevOps" ]]; then exit 0; fi
	
	
	gitProjectBase_="$gitProjectRoot_"

	gitRepos_="DevOps"

	
	#echo ">gitScriptWorker.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$gitProjectBase_" "$gitRepos_"
	bash "gitScriptWorker.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$gitProjectBase_" "$gitRepos_"

#!/bin/bash
 

	gitProject_="$1"
	gitCmd_="$2"
	gitMode_="$3"

    if [[ "$gitProject_" != "DevOps" ]]; then  exit 0;  fi


	gitProjectRoot="/home/craigory1958/_cwg-base"
	gitProjectBase="$gitProjectRoot"

	gitRepos="DevOps"

	
	if [[ -n "$BashUtils__tr" ]]; then echo "   >gitScriptWorker.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$gitProjectBase" "$gitRepos" "$bashTrace"; fi
	bash "gitScriptWorker.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$gitProjectBase" "$gitRepos" "$bashTrace"

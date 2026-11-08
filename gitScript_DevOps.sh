#!/bin/bash
 

	gitProject_="$1"
	gitCmd_="$2"
	gitMode_="$3"

    if [[ "$gitProject_" != "DevOps" ]]; then  exit 0;  fi


	gitProjectRoot_="/home/craigory1958/_cwg-base"
	gitProjectBase_="$gitProjectRoot_"

	gitRepos_="DevOps"

	
	if [[ -n "$BashUtils__tr" ]]; then echo "   >gitScriptWorker.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$gitProjectBase_" "$gitRepos_" "$bashTrace"; fi
	bash "gitScriptWorker.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$gitProjectBase_" "$gitRepos_" "$bashTrace"

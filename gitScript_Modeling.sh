#!/bin/bash


	gitProject_="$1"
	gitCmd_="$2"
	gitMode_="$3"

    if [[ "$gitProject_" != "Modeling" ]]; then  exit 0;  fi
	
	
	gitProjectRoot="/home/craigory1958/_cwg-base__Home"
	gitProjectBase="$gitProjectRoot/$gitProject_"

	gitRepos="Model-Rocketry<__docs,_electronics !Plastic-Modeling<__docs,_electronics TiddlyWiki"


	if [[ -n "$BashUtils__tr" ]]; then echo "   >gitScriptWorker.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$gitProjectBase" "$gitRepos" "$bashTrace"; fi
	bash "gitScriptWorker.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$gitProjectBase" "$gitRepos" "$bashTrace"
		
	
	if [[ "${gitMode_^^}" == "PURGE" ]]; then 

		echo "    purging $gitProject_ @$gitProjectBase ..."
		
		find "$gitProjectBase/__git/$gitProject_/"*  -not -path */.git/*  -delete  2>/dev/null
		find "$gitProjectBase/__git/$gitProject_/".*  -not -path */.git/*  -delete  2>/dev/null   # delete hidden files & folders.
	fi


	if [[ "${gitCmd_^^}" == "MERGE" ]]; then 
	
		echo "    merging $gitProject_ @$gitProjectBase ..."
		
		rsync -a  --exclude *".ignore."*  "$gitProjectBase/"*.*  "$gitProjectBase/__git/$gitProject_"/  2>/dev/null
		rsync -a  --exclude *".ignore."*  "$gitProjectBase/__docs/"  "$gitProjectBase/__git/$gitProject_/docs/"  2>/dev/null
	
		rsync -a  --exclude *".ignore."*  "$gitProjectBase/_ElectronicBuildBooks/"*.*  "$gitProjectBase/__git/$gitProject_/_ElectronicBuildBooks/"  2>/dev/null
		rsync -a  --exclude *".ignore."*  "$gitProjectBase/_ElectronicBuildBooks/_resources/"  "$gitProjectBase/__git/$gitProject_/_ElectronicBuildBooks/_resources/"  2>/dev/null
	fi

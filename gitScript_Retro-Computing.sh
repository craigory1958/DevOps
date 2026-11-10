#!/bin/bash


	gitProject_="$1"
	gitCmd_="$2"
	gitMode_="$3"

    if [[ "$gitProject_" != "Retro-Computing" ]]; then  exit 0;  fi
	
	
	gitProjectRoot="/home/craigory1958/_cwg-base__Home"
	gitProjectBase="$gitProjectRoot/Computer-Architecture/$gitProject_"

	gitRepos="RetroShield_6502 SBC6502 VMK6502|Virtual-Memory-Kernal XA"

	
	if [[ -n "$BashUtils__tr" ]]; then echo "   >gitScriptWorker.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$gitProjectBase" "$gitRepos" "$bashTrace"; fi
	bash "gitScriptWorker.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$gitProjectBase" "$gitRepos" "$bashTrace"
		
	
	if [[ "${gitMode_^^}" == "PURGE" ]]; then 

		echo "    purging $gitProject_ @$gitProjectBase ..."
		
		find "$gitProjectBase/__git/$gitProject_/"*  -not -path */.git/*  -delete  2>/dev/null
		find "$gitProjectBase/__git/$gitProject_/".*  -not -path */.git/*  -delete  2>/dev/null
	fi


	if [[ "${gitCmd_^^}" == "MERGE" ]]; then 
	
		echo "    merging $gitProject_ @$gitProjectBase ..."
		
		rsync -a  "$gitProjectBase/__docs/"  "$gitProjectBase/__git/$gitProject_/docs/"  2>/dev/null
	

		gitProjectPath="$gitProjectBase/RetroShield_Carrier"
		gitProjectGitPath="$gitProjectBase/RetroShield_6502/__git/RetroShield_6502/RetroShield_Carrier"
		echo "    merging RetroShield_Carrier @$gitProjectPath ..."
			
		rsync -a  --exclude *".ignore."*  "$gitProjectPath/"*.*  "$gitProjectGitPath"/  2>/dev/null
		rsync -a  --exclude *".ignore."*  "$gitProjectPath/".*  "$gitProjectGitPath"/  2>/dev/null
		
		
		for dir in "$gitProjectPath"/*; do

			if [[ -d "$dir" ]]; then
			
				folder=${dir##*/}
				case $folder in
			
					"__freecad") 
						rsync -a  --exclude *".ignore."*  "$gitProjectPath/$folder/"  "$gitProjectGitPath/_3d_freecad/"  2>/dev/null;;
				
					*) 
						rsync -a  --exclude *".ignore."*  "$gitProjectPath/$folder/"  "$gitProjectGitPath/$folder/"  2>/dev/null;;
				esac
			fi
		done
	fi

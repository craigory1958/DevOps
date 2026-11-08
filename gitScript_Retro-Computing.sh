#!/bin/bash


	gitProject_="$1"
	gitCmd_="$2"
	gitMode_="$3"

    if [[ "$gitProject_" != "Retro-Computing" ]]; then  exit 0;  fi
	
	
	gitProjectRoot_="/home/craigory1958/_cwg-base__Home"
	gitProjectBase_="$gitProjectRoot_/Computer-Architecture/$gitProject_"

	gitRepos_="RetroShield_6502 SBC6502 VMK6502|Virtual-Memory-Kernal XA"

	
	if [[ -n "$BashUtils__tr" ]]; then echo "   >gitScriptWorker.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$gitProjectBase_" "$gitRepos_" "$bashTrace"; fi
	bash "gitScriptWorker.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$gitProjectBase_" "$gitRepos_" "$bashTrace"
		
			
	if [[ "${gitCmd_^^}" == "MERGE" ]]; then 

		gitProjectPath_="$gitProjectBase_/RetroShield_Carrier"
		gitProjectGitPath_="$gitProjectBase_/RetroShield_6502/__git/RetroShield_6502/RetroShield_Carrier"
		echo "    copying RetroShield_Carrier @$gitProjectPath_ ..."

			
		rsync -a  --exclude *".ignore."*  "$gitProjectPath_/"*.*  "$gitProjectGitPath_"/  2>/dev/null
		rsync -a  --exclude *".ignore."*  "$gitProjectPath_/".*  "$gitProjectGitPath_"/  2>/dev/null
		
		
		for dir_ in "$gitProjectPath_"/*; do

			if [[ -d "$dir_" ]]; then
			
				dir_=${dir_##*/}
				case $dir_ in
			
					"__freecad") 
						rsync -a  "$gitProjectPath_/__freecad/"  "$gitProjectGitPath_/_3d_freecad/"  2>/dev/null;;
				
					*) 
						rsync -a  "$gitProjectPath_/$dir_/"  "$gitProjectGitPath_/$dir_/"  2>/dev/null;;
				esac
			fi
		done
	fi

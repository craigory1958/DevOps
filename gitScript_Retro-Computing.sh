#!/bin/bash
 
 
 	#echo "<0[$0] 1[$1] 2[$2] 3[$3]"
	
	gitProject_="$1"
	gitCmd_="$2"
	gitMode_="$3"
		
	gitProjectRoot_="/home/craigory1958/_cwg-base__Home"


    if [[ "$gitProject_" != "Retro-Computing" ]]; then exit 0; fi
	
	
	gitProjectBase_="$gitProjectRoot_/Computer-Archetecture/$gitProject_"

	gitRepos_="RetroShield_6502 SBC6502 VMK6502 XA"

	
	#echo ">gitScriptWorker.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$gitProjectBase_" "$gitRepos_"
	bash "gitScriptWorker.sh" "$gitProject_" "$gitCmd_" "$gitMode_" "$gitProjectBase_" "$gitRepos_"
		
			
	if [[ "${gitCmd_^^}" == "MERGE" ]]; then 

		gitProjectPath_="$gitProjectBase_/RetroShield_Carrier"
		gitProjectGitPath_="$gitProjectBase_/RetroShield_6502/__git/RetroShield_6502/RetroShield_Carrier"
			echo "merging RetroShield_Carrier @$gitProjectPath_ ..."

			
		#if [[ -f "$gitProjectPath_/"*.* ]]; then
			rsync -a  --exclude *".ignore."*  "$gitProjectPath_/"*.*  "$gitProjectGitPath_"/  2>/dev/null
		#fi
			
		#if [[ -f "$gitProjectPath_/".* ]]; then
			rsync -a  --exclude *".ignore."*  "$gitProjectPath_/".*  "$gitProjectGitPath_"/  2>/dev/null
		#fi
		
		
		for dir in "$gitProjectPath_"/*; do

			if [[ -d "$dir" ]]; then
			
				dir_=${dir##*/}
				case $dir_ in
			
					"__freecad") 
						rsync -a  "$gitProjectPath_/__freecad/"  "$gitProjectGitPath_/_3d_freecad/"  2>/dev/null;;
				
					*) 
						rsync -a  "$gitProjectPath_/$dir_/"  "$gitProjectGitPath_/$dir_/"  2>/dev/null;;
				esac
			fi
		done
	fi

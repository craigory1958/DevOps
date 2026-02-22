#!/bin/bash
 
 
 	#echo "<0[$0] 1[$1] 2[$2] 3[$3] 4[$4] 5[$5]"
	
	gitProject_="$1"
	gitCmd_="$2"
	gitMode_="$3"
	gitProjectBase_="$4"
	gitRepos_="$5"


	if [[ "${gitMode_^^}" == "PURGE" ]]; then 
	
		for project in $gitRepos_ ; do
		
			gitProjectGitPath_="$gitProjectBase_/$project/__git/$project"
			
			echo "purging $project @$gitProjectGitPath_ ..."
			
			#if [[ -f "$gitProjectGitPath_/"* ]]; then
				find "$gitProjectGitPath_/"*  -not -path *"/.git/"*  -delete  2>/dev/null
			#fi
			
			# if [[ -f "$gitProjectGitPath_/".* ]]; then
				#find "$gitProjectGitPath_/".*  -not -path *"/.git/"*  -delete  2>/dev/null
			# fi
		done
	fi


	if [[ "${gitCmd_^^}" == "MERGE" ]]; then 
	
		for project in $gitRepos_ ; do
			
			gitProjectPath_="$gitProjectBase_/$project"
			gitProjectGitPath_="$gitProjectBase_/$project/__git/$project"
			
			echo "merging $project @$gitProjectPath_ ..."

			#if [[ -f "$gitProjectPath_/"*.* ]]; then
				rsync -a  --exclude *".ignore."*  "$gitProjectPath_/"*.*  "$gitProjectGitPath_"/  2>/dev/null
			#fi
				
			#if [[ -f "$gitProjectPath_/".* ]]; then
				rsync -a  --exclude *".ignore."*  "$gitProjectPath_/".*  "$gitProjectGitPath_"/  2>/dev/null
			#fi
			
			for dir in "$gitProjectPath_"/*; do
  
				if [[ -d "$dir" && ("$dir" != */"__git") ]]; then
				
					dir_=${dir##*/}
					case $dir_ in
		
						"__eclipse") 
							rsync -a  --exclude "/.metadata"  --exclude "__Testomatic"  "$gitProjectPath_/__eclipse/"  "$gitProjectGitPath_/_maven_eclipse/"  2>/dev/null;;
		
						"__kicad")
							rsync -a  "$gitProjectPath_/__kicad/"  "$gitProjectGitPath_/_pcb_kicad/"  2>/dev/null;;
		
						"__freecad") 
							rsync -a  "$gitProjectPath_/__freecad/"  "$gitProjectGitPath_/_3d_freecad/"  2>/dev/null;;
				
						"__pio") 
							rsync -a  --exclude "/.pio"  --exclude "/.vscode"  "$gitProjectPath_/__pio/"  "$gitProjectGitPath_/_arduino_pio/"  2>/dev/null;;
				
						"grammars") 
							rsync -a  "$gitProjectPath_/grammars/"  "$gitProjectGitPath_/_grammars_antlr/"  2>/dev/null;;
					
						*) 
							rsync -a  "$gitProjectPath_/$dir_/"  "$gitProjectGitPath_/$dir_/"  2>/dev/null;;
					esac
				fi
			done
		done
	fi

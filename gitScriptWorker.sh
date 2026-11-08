#!/bin/bash
 

	gitProject_="$1"
	gitCmd_="$2"
	gitMode_="$3"
	gitProjectBase_="$4"
	gitRepos_="$5"


	if [[ "${gitMode_^^}" == "PURGE" ]]; then 
	
		for repo_ in $gitRepos_ ; do

			IFS="|" read -ra tokens <<< "$repo_"
			repoGit_="${tokens[0]}"
			[[ ${#tokens[@]} -ge 2 ]] && repoProject_="${tokens[1]}" || repoProject_="${tokens[0]}"
			
			gitRepoPath="$gitProjectBase_/$repoProject_/__git/$repoGit_"
			
			echo "    purging $repoGit_ @$gitRepoPath ..."


			find "$gitRepoPath/"*  -not -path */.git/*  -delete  2>/dev/null
			find "$gitRepoPath/".*  -not -path */.git/*  -delete  2>/dev/null
		done
	fi


	if [[ "${gitCmd_^^}" == "MERGE" ]]; then 
	
		for repo_ in $gitRepos_ ; do

			IFS="|" read -ra tokens <<< "$repo_"
			repoGit_="${tokens[0]}"
			[[ ${#tokens[@]} -ge 2 ]] && repoProject_="${tokens[1]}" || repoProject_="${tokens[0]}"
			
			gitProjectPath_="$gitProjectBase_/$repoProject_"
			gitRepoPath="$gitProjectBase_/$repoProject_/__git/$repoGit_"
			
			echo "    merging $repoGit_ @$gitProjectPath_ ..."


			rsync -a  --exclude *.ignore.*  "$gitProjectPath_/"*.*  "$gitRepoPath/"  2>/dev/null
			rsync -a  --exclude *.ignore.*  "$gitProjectPath_/".*  "$gitRepoPath/"  2>/dev/null
			

			for dir_ in "$gitProjectPath_"/*; do
  
				if [[ -d "$dir_" && ("$dir_" != */"__git") ]]; then
				
					dir_=${dir_##*/}
					case $dir_ in
		
						"__eclipse") 
							rsync -a  --exclude "/.metadata"  --exclude "__Testomatic"  "$gitProjectPath_/__eclipse/"  "$gitRepoPath/_maven_eclipse/"  2>/dev/null;;
		
						"__kicad")
							rsync -a  "$gitProjectPath_/__kicad/"  "$gitRepoPath/_pcb_kicad/"  2>/dev/null;;
		
						"__freecad") 
							rsync -a  "$gitProjectPath_/__freecad/"  "$gitRepoPath/_3d_freecad/"  2>/dev/null;;
				
						"__pio") 
							rsync -a  --exclude "/.pio"  --exclude "/.vscode"  "$gitProjectPath_/__pio/"  "$gitRepoPath/_arduino_pio/"  2>/dev/null;;
				
						"grammars") 
							rsync -a  "$gitProjectPath_/grammars/"  "$gitRepoPath/_grammars_antlr/"  2>/dev/null;;
					
						*) 
							rsync -a  "$gitProjectPath_/$dir_/"  "$gitRepoPath/$dir_/"  2>/dev/null;;
					esac
				fi
			done
		done
	fi

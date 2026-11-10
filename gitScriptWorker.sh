#!/bin/bash
 

	gitProject_="$1"
	gitCmd_="$2"
	gitMode_="$3"
	gitProjectBase_="$4"
	gitRepos_="$5"


	containsValue() {
    
		[[ $# -eq 1 ]] && return 0    # return 'found' if no items to serach


    	local value="$1"
    	shift

		local item
    	for item in "$@"; do
        	[[ "$item" == "$value" ]] && return 0   # return 'found' if items contains value
    	done

    	return 1
	}


	mergeFolder() {

		local dir="$1"
		local projectPath="$2"
		local repoPath="$3"

				
		local folder=${dir##*/}
		case $folder in
		
			"__docs") 
				rsync -a  --exclude *".ignore."*  "$projectPath/$folder/"  "$repoPath/docs/"  2>/dev/null;;

			"__eclipse") 
				rsync -a  --exclude *".ignore."*  --exclude "/.metadata"  --exclude "__Testomatic"  "$projectPath/$folder/"  "$repoPath/_maven_eclipse/"  2>/dev/null;;
		
			"__kicad")
				rsync -a  --exclude *".ignore."*  "$projectPath/$folder/"  "$repoPath/_pcb_kicad/"  2>/dev/null;;
		
			"__freecad") 
				rsync -a  --exclude *".ignore."*  "$projectPath/$folder/"  "$repoPath/_3d_freecad/"  2>/dev/null;;
				
			"__pio") 
				rsync -a  --exclude *".ignore."*  --exclude "/.pio"  --exclude "/.vscode"  "$projectPath/$folder/"  "$repoPath/_arduino_pio/"  2>/dev/null;;
				
			"grammars") 
				rsync -a  --exclude *".ignore."*  "$projectPath/$folder/"  "$repoPath/_grammars_antlr/"  2>/dev/null;;
					
			*) 
				rsync -a  --exclude *".ignore."*  "$projectPath/$folder/"  "$repoPath/$folder/"  2>/dev/null;;
		esac
	}


	if [[ "${gitMode_^^}" == "PURGE" ]]; then 
	
		for repo_ in $gitRepos_ ; do

			IFS="<" read -ra repoFolders <<< "$repo_"    # strip off any folder specs.
			IFS="|" read -ra repoTokens <<< "${repoFolders[0]}"
			[[ "${repoTokens[0]:0:1}" == "!" ]] && repoGit="${repoTokens[0]:1}" || repoGit="${repoTokens[0]}"
			[[ ${#repoTokens[@]} -ge 2 ]] && repoProject="${repoTokens[1]}" || repoProject="$repoGit"
			
			gitRepoPath="$gitProjectBase_/$repoProject/__git/$repoGit"
			

			echo "    auto-purging $repoGit @$gitRepoPath ..."

			find "$gitRepoPath/"*  -not -path */.git/*  -delete  2>/dev/null
			find "$gitRepoPath/".*  -not -path */.git/*  -delete  2>/dev/null   # delete hidden files & folders.
		done
	fi


	if [[ "${gitCmd_^^}" == "MERGE" ]]; then 
	
		for repo_ in $gitRepos_ ; do

			IFS="<" read -ra repoFolderTokens <<< "$repo_"
			IFS="," read -ra repoFolders <<< "${repoFolderTokens[1]}"

			IFS="|" read -ra repoTokens <<< "${repoFolderTokens[0]}"
			[[ "${repoTokens[0]:0:1}" == "!" ]] && processProjectHome="" || processProjectHome=true
			[[ "${repoTokens[0]:0:1}" == "!" ]] && repoGit="${repoTokens[0]:1}" || repoGit="${repoTokens[0]}"
			[[ ${#repoTokens[@]} -ge 2 ]] && repoProject="${repoTokens[1]}" || repoProject="$repoGit"

			gitProjectPath="$gitProjectBase_/$repoProject"
			gitRepoPath="$gitProjectBase_/$repoProject/__git/$repoGit"

			
			echo "    auto-merging $repoGit @$gitProjectPath ..."

			if [[ -n "$processProjectHome" ]]; then  rsync -a  --exclude *.ignore.*  "$gitProjectPath/"*.*  "$gitRepoPath/"  2>/dev/null; fi
			#rsync -a  --exclude *.ignore.*  "$gitProjectPath/".*  "$gitRepoPath/"  2>/dev/null   # copy hidden files & folders.
			

			for dir in "$gitProjectPath/"*; do
				folder=${dir##*/}
				if [[ -d "$dir" && ("$dir" != *"/__git") ]]; then

					if containsValue "$folder" "${repoFolders[@]}"; then  mergeFolder "$dir" "$gitProjectPath" "$gitRepoPath";  fi
				fi
			done
		done
	fi

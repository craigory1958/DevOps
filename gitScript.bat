

	ECHO OFF

	SET gitRepo=
	SET gitRepo_=%~1
	IF "%gitRepo_%"=="" (
		ECHO.
		ECHO [1] Arduino-Libraries
		ECHO [2] Plastic-Modeling
		ECHO [3] Retro-Computing
		ECHO [4] xcom-maven-parent
		ECHO [5] xcom-apps-4j
		ECHO [6] xcom-utilities-4j
		ECHO [7] xcom-web-utilities-4j
		SET /P gitRepo=Repo [1]?: 
	)

	IF "%gitRepo_%"=="" IF "%gitRepo%"=="" SET gitRepo=1
	IF /I "%gitRepo%"=="1" SET gitRepo_=Arduino-Libraries
	IF /I "%gitRepo%"=="2" SET gitRepo_=Plastic-Modeling
	IF /I "%gitRepo%"=="3" SET gitRepo_=Retro-Computing
	IF /I "%gitRepo%"=="4" SET gitRepo_=xcom-maven-parent
	IF /I "%gitRepo%"=="5" SET gitRepo_=xcom-apps-4j
	IF /I "%gitRepo%"=="6" SET gitRepo_=xcom-utilities-4j
	IF /I "%gitRepo%"=="7" SET gitRepo_=xcom-web-utilities-4j


	SET gitCmd=
	SET gitCmd_=%~2
	IF "%gitCmd_%"=="" (
		ECHO.
		ECHO [P] set Project
		ECHO [M] Merge
		ECHO [S] Stage
		SET /P gitCmd=Command [P]?: 
	)

	IF "%gitCmd_%"=="" IF "%gitCmd%"=="" SET gitCmd=P
	IF /I "%gitCmd%"=="P" SET gitCmd_=PROJECT
	IF /I "%gitCmd%"=="M" SET gitCmd_=MERGE
	IF /I "%gitCmd%"=="S" SET gitCmd_=STAGE

	IF /I "%gitCmd_%"=="PROJECT" GOTO gitCall


	SET gitMode=
	SET gitMode_=%~3
	IF "%gitMode_%"=="" (
		ECHO.
		ECHO [P] Purge
		ECHO [O] Overwrite
		IF /I "%gitCmd_%"=="MERGE" SET /P gitMode=Command [P]?: 
		IF /I "%gitCmd_%"=="STAGE" SET /P gitMode=Command [O]?: 
	)

	IF /I "%gitCmd_%"=="MERGE" IF "%gitMode_%"=="" IF "%gitMode%"=="" SET gitMode=P
	IF /I "%gitCmd_%"=="STAGE" IF "%gitMode_%"=="" IF "%gitMode%"=="" SET gitMode=O
	IF /I "%gitMode%"=="P" SET gitMode_=PURGE
	IF /I "%gitMode%"=="O" SET gitMode_=OVERWRITE


:gitCall

	IF /I "%gitCmd_%"=="PROJECT" (
		SETX CWG_project ""
		SETX CWG_gitRepo ""
		SETX CWG_gitRepoDir ""
		SETX CWG_docsDir ""
		SETX CWG_kicadBuildDir ""
		SETX CWG_pioBuilsDir ""
	)

echo on
	CALL gitScript_%gitRepo_%.bat "%gitRepo_%" "%gitCmd_%" "%gitMode_%"


:gitExit



	ECHO OFF

	IF /I NOT "%~1"=="xcom-apps-4j" GOTO gitExit


	SET gitMode_=%~3

	SET stageDir_=W:\_cwg-base__BDSessentials\XCOM\Java Apps
	IF NOT "%~4"=="" SET stageDir_=%4


	ECHO.
	ECHO xcom-apps-4j
	ECHO.
	ECHO  gitRepo: %~1
	ECHO   gitCmd: %~2
	ECHO  gitMode: %gitMode_%
	ECHO stageDir: %stageDir_%


	SET gitDir=%stageDir_%\__git\xcom-apps-4j


	IF /I "%~2"=="MERGE" GOTO gitMerge
	IF /I "%~2"=="PROJECT" GOTO gitProject
	IF /I "%~2"=="STAGE" GOTO gitStage

	GOTO gitExit


:gitProject

	SET CWG_project=xcom-apps-4j
	SET CWG_gitRepo=https://github.com/craigory1958/xcom-apps-4j.git
	SET CWG_gitRepoDir=W:\_cwg-base__BDSessentials\XCOM\Java Apps\__git
	SET CWG_docsDir=W:\_cwg-base__BDSessentials\XCOM\Java Apps\docs
	SET CWG_eclipseBuilsDir=W:\_cwg-base__BDSessentials\XCOM\Java Apps\__eclipse

	GOTO gitExit


:gitMerge

    IF /I "%gitMode_%"=="PURGE" GOTO gitMerge_Purge 
	goto gitMerge_Merge
 
:gitMerge_Purge
    ECHO ON

	FOR /F "tokens=*" %%f IN ( 'DIR /B /A:-D "%gitDir%\*" ^| FIND /V ".git"' ) DO DEL "%gitDir%\%%f"
	FOR /F "tokens=*" %%f IN ( 'DIR /B /AD "%gitDir%\*" ^| FIND /V ".git"' ) DO RD /S /Q "%gitDir%\%%f"
	

    ECHO OFF
    GOTO gitMerge_Merge
	
:gitMerge_Merge
    ECHO ON

    XCOPY "%stageDir_%\." "%gitDir%\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /Q /Y
    XCOPY "%stageDir_%\docs\." "%gitDir%\docs\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y
    XCOPY "%stageDir_%\__eclipse\Java Apps\." "%gitDir%\_maven_eclipse\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y

    ECHO OFF
    GOTO gitExit


:gitExit

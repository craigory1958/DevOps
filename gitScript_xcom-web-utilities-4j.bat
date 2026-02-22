

ECHO OFF

IF /I NOT "%~1"=="xcom-web-utilities-4j" GOTO gitExit


SET purge=%~3
SET gitDir=%~4

SET stageDir=W:\_cwg-base__BDSessentials\XCOM\
IF NOT "%~5"=="" SET stageDir=%5


ECHO.
ECHO 1 - %~1
ECHO 2 - %~2
ECHO 3 - %purge%
ECHO 4 - %gitDir%
ECHO 5 - %stageDir%


IF /I "%~2"=="DEPLOY" GOTO gitDeploy
IF /I "%~2"=="MERGE" GOTO gitMerge

GOTO gitExit


:gitDeploy

    IF /I NOT "%purge%"=="PURGE" GOTO gitDeploy_skipPurge 
    ECHO ON

	rem FOR /D %%a IN ("%stageDir%xcom-web-utilities-4j\*") DO IF /i NOT "%%~nxa"=="*.gitexclude*" RD /S /Q "%%a"
    
    ECHO OFF
:gitDeploy_skipPurge
    ECHO ON

    rem XCOPY "%gitDir%%~1\." "%stageDir%xcom-web-utilities-4j\" /S /E /Y /Q

    ECHO OFF
    GOTO gitExit


:gitMerge

    IF /I NOT "%purge%"=="PURGE" GOTO gitMerge_skipPurge 
    ECHO ON

    FOR %%f IN ("%gitDir%%~1\*") DO IF NOT "%%f"==.git DEL "%%f"
	FOR /D %%d IN ("%gitDir%%~1\*") DO IF /I NOT "%%~nxd"==".git" RD /S /Q "%%d"
 
    ECHO OFF
:gitMerge_skipPurge 
    ECHO ON

    XCOPY "%stageDir%Java Web Utilities\." "%gitDir%%~1\" /EXCLUDE:_gitScript__ExcludeFiles.txt /Q /Y
    XCOPY "%stageDir%Java Web Utilities\__eclipse\Java Web Utilities\." "%gitDir%%~1\Java Web Utilities\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y

    ECHO OFF
    GOTO gitExit


:gitExit

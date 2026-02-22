

	ECHO OFF

	IF /I NOT "%~1"=="Retro-Computing" GOTO gitExit


	SET gitCmd_=%~2


	SET gitMode_=%~3
	

	SET stageDir_=Z:\_cwg-base__Home\Computer-Archetecture\Retro-Computing
	IF NOT "%~4"=="" SET stageDir_=%4


	SET project=
	SET project_=%~5
	IF "%gitCmd_%"=="PROJECT" (
		IF "%project_%"=="" (
			ECHO.
			ECHO [1] RetroPanel_6502
			ECHO [2] RetroShield_6502
			ECHO [3] RetroShield_Carrier
			ECHO [4] SBC6502
			ECHO [5] Virtual-Memory-Kernel
			ECHO [6] XA
			SET /P project=Project []?: 
		)
	)

	IF /I "%project%"=="1" SET project_=RetroPanel_6502
	IF /I "%project%"=="2" SET project_=RetroShield_6502
	IF /I "%project%"=="3" SET project_=RetroShield_Carrier
	IF /I "%project%"=="4" SET project_=SBC6502
	IF /I "%project%"=="5" SET project_=VMK6502
	IF /I "%project%"=="6" SET project_=XA


	ECHO.
	ECHO Retro-Computing
	ECHO.
	ECHO  gitRepo: %~1
	ECHO   gitCmd: %gitCmd_%
	ECHO  gitMode: %gitMode_%
	ECHO stageDir: %stageDir_%
	ECHO  project: %project_%


	SET gitDir=%stageDir_%\__git\Retro-Computing
	SET gitDir_RetroShield_6502=%stageDir_%\RetroShield_6502\__git\RetroShield_6502
	SET gitDir_SBC6502=%stageDir_%\SBC6502\__git\SBC6502
	SET gitDir_VMK6502=%stageDir_%\Virtual-Memory-Kernel\__git\VMK6502
	SET gitDir_XA=%stageDir_%\XA\__git\XA


	IF /I "%~2"=="MERGE" GOTO gitMerge
	IF /I "%~2"=="PROJECT" GOTO gitProject
	IF /I "%~2"=="STAGE" GOTO gitStage

	GOTO gitExit


:gitProject

	IF "%project_%"=="SBC6502" (
		SETX CWG_project "SBC6502"
		SETX CWG_gitRepo "https://github.com/craigory1958/SBC6502.git"
		SETX CWG_gitRepoDir "Z:\_cwg-base__Home\Computer-Archetecture\Retro-Computing\SBC6502\__git\SBC6502"
		SETX CWG_docsDir "Z:\_cwg-base__Home\Computer-Archetecture\Retro-Computing\SBC6502\docs"
		SETX CWG_kicadBuildDir "Z:\_cwg-base__Home\Computer-Archetecture\Retro-Computing\SBC6502\__kicad"
		SETX CWG_pioBuilsDir "Z:\_cwg-base__Home\Computer-Archetecture\Retro-Computing\SBC6502\__pio"
	)
	
	ECHO.
	SET CWG_

	GOTO gitExit



:gitMerge

    IF /I "%gitMode_%"=="PURGE" GOTO gitMerge_Purge 
	GOTO gitMerge_Merge
 
:gitMerge_Purge
    ECHO ON
	
	
	rem Purge Retro-Computer parent module ///

	FOR /F "tokens=*" %%f IN ( 'DIR /B /A:-D "%gitDir%\*" ^| FIND /V ".git"' ) DO DEL "%gitDir%\%%f"
	FOR /F "tokens=*" %%f IN ( 'DIR /B /AD "%gitDir%\*" ^| FIND /V ".git"' ) DO (
		IF NOT "%%f"=="RetroShield_6502" IF NOT "%%f"=="SBC6502" IF NOT "%%f"=="VMK6502" IF NOT "%%f"=="XA" (
		    RD /S /Q "%gitDir%\%%f"
		)
	)

	FOR /F "tokens=*" %%f IN ( 'DIR /B /A:-D "%gitDir%\RetroShield_6502\*" ^| FIND /V ".git"' ) DO DEL "%gitDir%\RetroShield_6502\%%f"
	FOR /F "tokens=*" %%f IN ( 'DIR /B /AD "%gitDir%\RetroShield_6502\*" ^| FIND /V ".git"' ) DO RD /S /Q "%gitDir%\RetroShield_6502\%%f"

	FOR /F "tokens=*" %%f IN ( 'DIR /B /A:-D "%gitDir%\SBC6502\*" ^| FIND /V ".git"' ) DO DEL "%gitDir%\SBC6502\%%f"
	FOR /F "tokens=*" %%f IN ( 'DIR /B /AD "%gitDir%\SBC6502\*" ^| FIND /V ".git"' ) DO RD /S /Q "%gitDir%\SBC6502\%%f"

	FOR /F "tokens=*" %%f IN ( 'DIR /B /A:-D "%gitDir%\VMK6502\*" ^| FIND /V ".git"' ) DO DEL "%gitDir%\VMK6502\%%f"
	FOR /F "tokens=*" %%f IN ( 'DIR /B /AD "%gitDir%\VMK6502\*" ^| FIND /V ".git"' ) DO RD /S /Q "%gitDir%\VMK6502\%%f"

	FOR /F "tokens=*" %%f IN ( 'DIR /B /A:-D "%gitDir%\XA\*" ^| FIND /V ".git"' ) DO DEL "%gitDir%\XA\%%f"
	FOR /F "tokens=*" %%f IN ( 'DIR /B /AD "%gitDir%\XA\*" ^| FIND /V ".git"' ) DO RD /S /Q "%gitDir%\XA\%%f"

    
	rem Purge submodules
	
    FOR %%f IN ("%gitDir_RetroShield_6502%\*") DO IF NOT "%%f"==.git DEL "%%f"
	FOR /D %%d IN ("%gitDir_RetroShield_6502%\*") DO IF /I NOT "%%~nxd"==".git" RD /S /Q "%%d"
	
    FOR %%f IN ("%gitDir_SBC6502%\*") DO IF NOT "%%f"==.git DEL "%%f"
	FOR /D %%d IN ("%gitDir_SBC6502%\*") DO IF /I NOT "%%~nxd"==".git" RD /S /Q "%%d"
	
    FOR %%f IN ("%gitDir_VMK6502%\*") DO IF NOT "%%f"==.git DEL "%%f"
	FOR /D %%d IN ("%gitDir_VMK6502%\*") DO IF /I NOT "%%~nxd"==".git" RD /S /Q "%%d"
	
    FOR %%f IN ("%gitDir_XA%\*") DO IF NOT "%%f"==.git DEL "%%f"
	FOR /D %%d IN ("%gitDir_XA%\*") DO IF /I NOT "%%~nxd"==".git" RD /S /Q "%%d"


    ECHO OFF
    GOTO gitExit
	GOTO gitMerge_Merge
	
	
:gitMerge_Merge 
    ECHO ON

    XCOPY "%stageDir_%\." "%gitDir%\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /Q /Y
    XCOPY "%stageDir_%\docs\." "%gitDir%\docs\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y


    rem XCOPY "%stageDir_%\Retro Computing\RetroPanel 6502\." "%gitDir%\%~1\RetroPanel 6502\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /Q /Y
    rem XCOPY "%stageDir_%\Retro Computing\RetroPanel 6502\__kicad\." "%gitDir%\%~1\RetroPanel 6502\_pcb_kicad\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y
 
 
	rem RetroShield_6502
	
    XCOPY "%stageDir_%\RetroShield_6502\." "%gitDir_RetroShield_6502%\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /Q /Y
    XCOPY "%stageDir_%\RetroShield_6502\docs\." "%gitDir_RetroShield_6502%\docs\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y
    XCOPY "%stageDir_%\RetroShield_6502\__pio\." "%gitDir_RetroShield_6502%\_arduino_pio\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y
  
    XCOPY "%stageDir_%\RetroShield_Carrier\." "%gitDir_RetroShield_6502%\RetroShield_Carrier\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /Q /Y
    XCOPY "%stageDir_%\RetroShield_Carrier\__freecad\." "%gitDir_RetroShield_6502%\RetroShield_Carrier\_3d_freecad\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y


	rem SBC6502
	
    XCOPY "%stageDir_%\SBC6502\." "%gitDir_SBC6502%\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /Q /Y
    XCOPY "%stageDir_%\SBC6502\docs\." "%gitDir_SBC6502%\docs\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y
    XCOPY "%stageDir_%\SBC6502\__kicad\." "%gitDir_SBC6502%\_pcb_kicad\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y
    XCOPY "%stageDir_%\SBC6502\__pio\." "%gitDir_SBC6502%\_arduino_pio\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y
	

	rem VMK6502
	
    XCOPY "%stageDir_%\Virtual-Memory-Kernel\." "%gitDir_VMK6502%\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /Q /Y
    XCOPY "%stageDir_%\Virtual-Memory-Kernel\VMK\." "%gitDir_VMK6502%\_a65\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y
 

	rem XA
	
    XCOPY "%stageDir_%\XA\." "%gitDir_XA%\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /Q /Y
    XCOPY "%stageDir_%\XA\docs\." "%gitDir_XA%\docs\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y
    XCOPY "%stageDir_%\XA\__eclipse\XA\." "%gitDir_XA%\_maven_eclipse\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y
    XCOPY "%stageDir_%\XA\grammars\." "%gitDir_XA%\_antlr\" /EXCLUDE:_gitScript__ExcludeFiles.txt /D /E /Q /S /Y

    ECHO OFF
    GOTO gitExit


:gitStage

    IF /I NOT "%gitMode_%"=="PURGE" GOTO gitStage_skipPurge 
    ECHO ON

	rem FOR /D %%a IN ("%stageDir_%\Retro-Computing\*") DO IF /i NOT "%%~nxa"=="*.gitexclude*" RD /S /Q "%%a"
    
    ECHO OFF
:gitStage_skipPurge
    ECHO ON

    rem XCOPY "%gitDir%%~1\." "%stageDir_%\Retro-Computing\" /S /E /Y /Q

    ECHO OFF
    GOTO gitExit


:gitExit

	ECHO.
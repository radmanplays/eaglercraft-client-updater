@echo off
echo Please install Git before running this file, and ONLY run this on a Git repository.

:: Create a new branch
git checkout -b vanilla-eagler-src
if %ERRORLEVEL% neq 0 (
    echo Please install Git before running this file. Exiting...
    exit /b 1
)

:: Download the ZIP file
echo Downloading Eaglercraft workspace...
curl -L -o master.zip https://git.eaglercraft.rip/eaglercraft/eaglercraft-1.8-workspace/archive/master.zip

:: Check if the download was successful
if %ERRORLEVEL% neq 0 (
    echo Error downloading the file. Exiting...
    exit /b 1
)

:: Extract the ZIP file
echo Extracting the ZIP file...
powershell -Command "Expand-Archive -Path 'master.zip' -DestinationPath '.'"

:: Check if the extraction was successful
if %ERRORLEVEL% neq 0 (
    echo Error extracting the file. Exiting...
    exit /b 1
)

:: Clean up the ZIP file
echo Cleaning up...
del master.zip

:: Prompt user for the main branch name
set /p default_branch=Enter the name of your main branch (e.g., main or master): 

:: Switch back to the default branch
git checkout %default_branch%

:: Merge the newly created branch
git merge %default_branch% vanilla-eagler-src --allow-unrelated-histories

:: Check if the merge was successful
if %ERRORLEVEL% neq 0 (
    echo Error during merge. Exiting...
    exit /b 1
)

echo Done. Use GitHub Desktop and VSCode to fix conflicts.

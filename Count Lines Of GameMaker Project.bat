@echo off

:CountLines
setlocal
set /a totalNumLines = 0
for /r %1 %%F in (*.gml) do (
    for /f %%N in ('find /v /c "" ^<"%%F"') do set /a totalNumLines+=%%N
    echo|set /p= "."
)

echo .
echo Total number of code lines = %totalNumLines%
echo Making progress!
pause
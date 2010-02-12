@ECHO OFF

SET TMPPATH=%PATH%
SET PATH=c:\itools\bin;%PATH%

h:
cd "h:\dida\lab3"

if %1=="build" goto build
if %1=="rebuild" goto rebuild

"ftee" "mk32" "%1" -a -r -f "BlinkKey.mak" > "BlinkKey.err"
goto end

:build
"ftee" "mk32" -r -f "BlinkKey.mak" > "BlinkKey.err"
goto end

:rebuild
"ftee" "mk32" -a -r -f "BlinkKey.mak" > "BlinkKey.err"

:end
SET PATH=%TMPPATH%

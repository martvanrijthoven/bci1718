call ..\..\utilities\findMatlab.bat
if %ismatlab%==1 (
  start "Matlab" /b %matexe% -r "runProject;quit;" %matopts%
) else (
  echo runProject;quit; | %matexe% %matopts%
)

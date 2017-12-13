call ..\..\utilities\findMatlab.bat
if %ismatlab%==1 (
  start "Matlab" /b %matexe% -r "configAndStartSigProcBufferProject;quit;" %matopts%
) else (
echo configAndStartSigProcBufferProject;quit; | %matexe% %matopts%
)

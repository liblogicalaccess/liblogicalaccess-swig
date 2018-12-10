call conan install -p compilers/x64_msvc_debug -u .
if %errorlevel% neq 0 exit /b %errorlevel%
call conan install -p compilers/x64_msvc_release -u .
if %errorlevel% neq 0 exit /b %errorlevel%
call conan install -p compilers/x86_msvc_debug -u .
if %errorlevel% neq 0 exit /b %errorlevel%
call conan install -p compilers/x86_msvc_release -u .
if %errorlevel% neq 0 exit /b %errorlevel%
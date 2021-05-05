if "%1"=="y" (SET buildprivate=False) else (SET buildprivate=True)

call conan install -p compilers/x64_msvc_debug -o LLA_BUILD_PRIVATE=%buildprivate% -u .
if %errorlevel% neq 0 exit /b %errorlevel%
call conan install -p compilers/x64_msvc_release -o LLA_BUILD_PRIVATE=%buildprivate% -u .
if %errorlevel% neq 0 exit /b %errorlevel%
call conan install -p compilers/x86_msvc_debug -o LLA_BUILD_PRIVATE=%buildprivate% -u .
if %errorlevel% neq 0 exit /b %errorlevel%
call conan install -p compilers/x86_msvc_release -o LLA_BUILD_PRIVATE=%buildprivate% -u .
if %errorlevel% neq 0 exit /b %errorlevel%
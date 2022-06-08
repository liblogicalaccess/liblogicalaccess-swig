# Environment setup 

You need SWIG version >= 3.0.12. 

If you use SWIG version 3.0.12, you have to copy the csharp folder from 'swig/csharp' and merge it with [SWIG directory]\Lib\csharp. 
This adds a few features not yet available on this SWIG version.

To build the project, take a look at root scripts `build-linux.sh` and `build-windows.ps1`.


# File structure

The project generates 2 DLLs, one native (C/C++), one for .NET.

 1. LibLogicalAccessNet.win32: 
 
Contains C code generated by SWIG from interfaces (*.i files). 

 2. LibLogicalAccessNet: 

.NET DLL that will contains all C# files generated by SWIG. A C++ DLL reference is required. We find here all PInvoke files as well, one for each builded interface. 
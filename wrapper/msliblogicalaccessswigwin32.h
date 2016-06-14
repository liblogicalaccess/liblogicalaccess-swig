/**
 * \file msliblogicalaccessswigwin32.h
 * \author Maxime Chamley <maxime.chamley@islog.eu>
 * \brief A Visual Studio needed file.
 * The following ifdef block is the standard way of creating macros which make exporting from a DLL simpler.
 *
 * All files within this DLL are compiled with the LIBLOGICALACCESSSWIG_EXPORTS symbol defined on the command line. 
 * This symbol should not be defined on any project that uses this DLL.
 * This way any other project whose source files include this file see LIBLOGICALACCESSSWIG_API functions as being imported from a DLL, whereas this DLL sees symbols defined with this macro as being exported.
 */

#ifndef MSLIBLOGICALACCESSSWIGWIN32_H
#define MSLIBLOGICALACCESSSWIGWIN32_H

#ifdef LIBLOGICALACCESSSWIGWIN32_EXPORTS
#define LIBLOGICALACCESSSWIGWIN32_API __declspec(dllexport)
#else
/**
 * \brief A MACRO usefull to use the same include files to compile and to use the library.
 */
#define LIBLOGICALACCESSSWIGWIN32_API __declspec(dllimport)
#endif

#endif /* MSLIBLOGICALACCESSSWIGWIN32_H */


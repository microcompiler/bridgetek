@echo off
setlocal

set MODE=
set COMPILER=
set CLEAN=
set PROGRAM=

set CFLAGS=
set LFLAGS=
set LFILES=
set LINCLUDE=
set PREFIX=

:HandleParameter
if [%1]==[] GOTO Continue
if [%1]==[--help] GOTO Help
if [%1]==[-help] GOTO Help
if [%1]==[help] GOTO Help
if [%1]==[--?] GOTO Help
if [%1]==[-?] GOTO Help
if [%1]==[?] GOTO Help
if [%1]==[/?] GOTO Help

if [%1]==[--release] (
  set MODE=RELEASE
  SHIFT
  GOTO HandleParameter
)
if [%1]==[--debug] (
  set MODE=DEBUG
  SHIFT
  GOTO HandleParameter
)
if [%1]==[--c++] (
  set COMPILER=CPP
  SHIFT
  GOTO HandleParameter
)
if [%1]==[--gcc] (
  set COMPILER=C
  SHIFT
  GOTO HandleParameter
)
if [%1]==[--clean] (
  set CLEAN=YES
  SHIFT
  GOTO HandleParameter
)
if [%1]==[--program] (
  set PROGRAM=YES
  SHIFT
  GOTO HandleParameter
)

echo Invalid command line option '%1'. Use '--help' for usage information.
echo.
exit /b 1

:Help
echo Command line script to build and program Bridgetek (FTDI) FT9XX embedded microcontroller.
echo.
echo Usage:
echo   BUILD [--release^|debug] [--gcc^|g++] [--clean] [--program]
echo.
echo   --release^|debug     : force compiler mode of either release or debug, if
echo                          not provided release mode will be used.
echo   --gcc^|c++           : force usage of either c++ or gcc compiler, if
echo                          not provided gcc compiler will be used.
echo   --clean              : remove build artifacts prior to compiling.
echo   --program            : build artifacts and program microcontroller.
echo.
echo.
echo   --help               : display this help text.
echo.
echo Example: the following commands, executed after each other will;
echo   build --release --program                     
echo                  Will build, link and program microcontroller.
echo.
exit /b

:Continue

if [%MODE%]==[DEBUG] (
    set CFLAGS=-Og -g -fvar-tracking -fvar-tracking-assignments -Wall -c -fmessage-length=0 -ffunction-sections -MMD -MP
    set LINCLUDE="%FT90X_TOOLCHAIN%/hardware/lib/Debug"
) else (
    set CFLAGS=-Os -Wall -c -fmessage-length=0 -ffunction-sections -MMD -MP
    set LINCLUDE="%FT90X_TOOLCHAIN%/hardware/lib/Release"
)
if [%COMPILER%]==[CPP] (
    set PREFIX=ft32-elf-g++
    set COMPILER=CPP
) else (
    set PREFIX=ft32-elf-gcc
    set COMPILER=C
)

%PREFIX% --version
IF not %ERRORLEVEL%==0 (
  echo.  
  echo No toolchain detected, please make sure you have the toolchain
  echo set up in your system path.
  exit /b 1
)

if not exist ..\build\nul (
  mkdir ..\build
  echo.
)

if [%CLEAN%]==[YES] (
  if exist ..\build\* del /q ..\build\* > con
  echo Build file cleaning completed.
  echo.
)

for /r ..\src %%F in (*.%COMPILER%) do (
  call :Concat "..\build\%%~nF.o"
  %PREFIX% -D__FT900__ -I"%FT90X_TOOLCHAIN%/hardware/include" -I"../include" %CFLAGS% -MF"..\build\%%~nF.d" -MT"..\build\%%~nF.o" -o"..\build\%%~nF.o" "%%~dpnxF"
  if %ERRORLEVEL% NEQ 0 GOTO Error
)

if not [%PROGRAM%]==[YES] (
  if not [%MODE%]==[DEBUG] (
    exit /b
  )
)

%PREFIX% -L%LINCLUDE% -Wl,--gc-sections -Wl,--entry=_start -o"..\build\firmware.elf" %LFILES% -lft900 -lc -lstub
if %ERRORLEVEL% NEQ 0 GOTO Error

ft32-elf-objcopy --output-target binary "..\build\firmware.elf"  "..\build\firmware.bin"
if %ERRORLEVEL% NEQ 0 GOTO Error

ft32-elf-size --format=berkeley -x "..\build\firmware.elf"
if %ERRORLEVEL% NEQ 0 GOTO Error

if not [%PROGRAM%]==[NO] (
  ft900prog -f "..\build\firmware.bin" -O -v
  if %ERRORLEVEL% NEQ 0 GOTO Error
)

:Exit
exit /b

:Error
exit /b 1

:Concat
set LFILES=%LFILES% %1

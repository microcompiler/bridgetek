# VSCode for Bridgetek/FTDI Microcontrollers

Use Visual Studio Code (VSCode) for building, debugging and flashing your Bridgetek FT90X projects using the UMFTPD2A debug/programmer module and FT9xx Toolchain.

![Image of Debugging](https://github.com/microcompiler/bridgetek/blob/master/images/vscode-debug.gif)

### Requirements
Hardware:
* UMFTPD2A debug/programmer module (https://brtchip.com/product/umftpd2a/)
* MM900EV-LITE development module (http://brtchip.com/product/mm900ev-lite/)

Software:
* Visual Studio Code (https://code.visualstudio.com/)
* Bridgetek FT9xx Toolchain (http://brtchip.com/ft9xx-toolchain/)

## Getting Started
Start development by installing Visual Studio Code and Bridgetek Toolchain on your PC, then finally how to clone, build and run the C/C++ code.
1. Download and install VSCode and the FT9xx Toolchain (only the toolchain, python and drivers are required)
1. Clone the firmware repository
1. Create an empty ./cpp/build and ./gcc/build folder directories. These directories must be created before you can run a task.
1. Directly from VSCode (Ctrl+Shift+X) install the following required extension:
  * C/C++

Open the VSCode Workspace file, which is located in the root of the bridgetek repository. It is called firmware.code-workspace. The first time you open it, VSCode will install some dependencies. You should now be ready to compile and test the FT9XX project.

### Building, Program and Debugging
#### Building the Firmware
* Tasks -> ft32:build (Ctrl+Shift+B)

#### Programing/Flashing the Firmware
* Tasks -> ft32:program (Alt+Ctrl+B)
 > If you receive the "Error: UMFTPD2A Module not found." error message.  Teriminate the "ft32:bridge" task and check the usb connection.

#### Debugging
* Debug -> Start Debugging (F5)
 > Set your breakpoints. Note: you can only set breakpoints when the processor is halted, if you set them during run mode, they won’t get applied.
* Run (F5)
 > Stepping over/in/out, restarting, and changing breakpoints can be done by first pressing the “pause” (F6) button at the top the screen. When done debugging, simply stop (Shift+F5) the debugger.
* Teriminate Tasks -> ft32:bridge (Alt+Ctrl+T)

### Contributions
Contributions to this project are always welcome.
# VSCode for Bridgetek/FTDI Microcontrollers

Use Visual Studio Code (VSCode) for coding, building and flashing your Bridgetek FT90X projects using the UMFTPD2A debug/programmer module and FT9xx Toolchain.

![Image of Debugging](https://github.com/microcompiler/bridgetek/blob/master/images/vscode-debug.png)

### Requirements
Hardware:
* UMFTPD2A debug/programmer module (https://brtchip.com/product/umftpd2a/)

Software:
* Visual Studio Code (https://code.visualstudio.com/)
* Bridgetek FT9xx Toolchain (http://brtchip.com/ft9xx-toolchain/)

## Getting Started
Start development by installing Visual Studio Code and Bridgetek Toolchain on your PC, then finally how to clone, build and run the C/C++ code.
1. Download and install VSCode and the FT9xx Toolchain (only the toolchain, python and drivers are required)
1. Clone the firmware repository
1. Directly from VSCode (Ctrl+Shift+X) install the following required extension:
  * C/C++

Open the VSCode Workspace file, which is located in the root of the bridgetek repository. It is called firmware.code-workspace. The first time you open it, VSCode will install some dependencies. You should now be ready to compile and test the FT9XX project.

### Building, Program and Debugging
#### Building the Firmware
* Tasks -> ft32:build

#### Programing/Flashing the Firmware
* Tasks -> ft32:program

#### Debugging
* Tasks -> ft32:bridge
* Debug -> Start Debugging (or press F5)
> Set your breakpoints. Note: you can only set breakpoints when the processor is halted, if you set them during run mode, they won’t get applied.
* Run (F5)
> Stepping over/in/out, restarting, and changing breakpoints can be done by first pressing the “pause” (F6) button at the top the screen. When done debugging, simply stop (Shift+F5) the debugger.

### Contributions
Contributions to this project are always welcome.
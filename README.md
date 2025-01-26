# Hello World in ARM64 Assembly (Windows)

A simple Hello World implementation in ARM64 assembly language for Windows systems.

## Installation

### Windows
Install Visual Studio with the following components:
- MSVC ARM64 build tools
- Windows SDK
- NASM

Alternatively, you can use the Windows ARM64 SDK command prompt directly.

## Running

From the Visual Studio ARM64 Native Tools Command Prompt:
```batch
nasm -f win64 main.asm -o main.obj
link main.obj /subsystem:console /entry:main /machine:ARM64 kernel32.lib
main.exe
```

## Code Explanation

The Windows implementation differs significantly from Unix-like systems because Windows doesn't expose system calls directly to user programs. Instead, we must use the Windows API (WinAPI) functions. Our program uses three key Windows API functions:

1. GetStdHandle - Retrieves a handle to the standard output device
2. WriteConsoleA - Writes a string to the console
3. ExitProcess - Terminates the program

The Windows ARM64 ABI (Application Binary Interface) requires us to:
- Save and restore the frame pointer (x29) and link register (x30)
- Use the bl (Branch and Link) instruction for function calls
- Follow the Windows ARM64 calling convention where:
  - Parameters are passed in x0-x7
  - x19-x28 are preserved across function calls
  - Return values come back in x0

The program's structure follows Windows conventions:
- External functions are declared with 'extern'
- Data is placed in a data section
- Code is placed in a text section
- The entry point is named 'main' and marked global

Note that unlike Unix systems, Windows ARM64:
- Requires explicit handle acquisition for I/O
- Uses different function calling conventions
- Has different memory protection and loader requirements
- Needs specific linker settings for proper executable generation

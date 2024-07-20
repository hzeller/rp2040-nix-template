cmake_minimum_required(VERSION 3.25)

# Need to include pico-sdk cmake support. Must happen before project.
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

project(blink
  LANGUAGES C CXX ASM
  VERSION 1.0
)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)  # Get compilation DB

# initialize the Raspberry Pi Pico SDK
pico_sdk_init()

# Tell CMake where to find the executable source file
add_executable(${PROJECT_NAME}
    blink.cc
)

# Create map/bin/hex/uf2 files
pico_add_extra_outputs(${PROJECT_NAME})

# Link to pico_stdlib (gpio, time, etc. functions)
target_link_libraries(${PROJECT_NAME}
    pico_stdlib
)

# Choice of available stdio outputs
pico_enable_stdio_usb(${PROJECT_NAME} 1)  # ~13880 extra bytes
pico_enable_stdio_uart(${PROJECT_NAME} 0) # ~1176 extra bytes

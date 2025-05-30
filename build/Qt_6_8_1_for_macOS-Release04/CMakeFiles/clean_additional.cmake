# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Release")
  file(REMOVE_RECURSE
  "CMakeFiles/appforHa_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appforHa_autogen.dir/ParseCache.txt"
  "appforHa_autogen"
  )
endif()

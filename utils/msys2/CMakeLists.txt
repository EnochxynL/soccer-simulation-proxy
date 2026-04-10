
if(WIN32)
  install(FILES
    ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start.ps1
    ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start-agent.ps1
    ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/keepaway.ps1
    ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/train.ps1
    ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/player.ps1
    DESTINATION bin
  )
else()
  install(PROGRAMS
    ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start.sh
    ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start-agent.sh
    ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/keepaway.sh
    ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/train.sh
    ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/player.sh
    DESTINATION bin
  )
endif()

if(WIN32)
  install(FILES
    ${PROJECT_SOURCE_DIR}/src/player.conf
    ${PROJECT_SOURCE_DIR}/src/coach.conf
    ${PROJECT_SOURCE_DIR}/src/start-debug.ps1
    ${PROJECT_SOURCE_DIR}/src/start-offline.ps1
    ${PROJECT_SOURCE_DIR}/src/start-debug-agent.ps1
    ${PROJECT_SOURCE_DIR}/idl/grpc/service.proto
    ${PROJECT_SOURCE_DIR}/idl/thrift/soccer_service.thrift
    DESTINATION bin
  )
else()
  install(FILES
    ${PROJECT_SOURCE_DIR}/src/player.conf
    ${PROJECT_SOURCE_DIR}/src/coach.conf
    ${PROJECT_SOURCE_DIR}/src/start-debug.sh
    ${PROJECT_SOURCE_DIR}/src/start-offline.sh
    ${PROJECT_SOURCE_DIR}/src/start-debug-agent.sh
    ${PROJECT_SOURCE_DIR}/idl/grpc/service.proto
    ${PROJECT_SOURCE_DIR}/idl/thrift/soccer_service.thrift
    DESTINATION bin
  )
endif()

install(DIRECTORY
  ${PROJECT_SOURCE_DIR}/src/formations-dt
  ${PROJECT_SOURCE_DIR}/src/formations-keeper
  ${PROJECT_SOURCE_DIR}/src/formations-taker
  DESTINATION bin
)

configure_file(
  ${PROJECT_SOURCE_DIR}/cmake/CollectRuntimeDepsWindows.cmake.in
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CollectRuntimeDepsWindows.cmake
  @ONLY
)

configure_file(
  ${PROJECT_SOURCE_DIR}/cmake/CollectRuntimeDepsUnix.cmake.in
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CollectRuntimeDepsUnix.cmake
  @ONLY
)

configure_file(
  ${PROJECT_SOURCE_DIR}/cmake/InstallRuntimeDeps.cmake.in
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/InstallRuntimeDeps.cmake
  @ONLY
)

if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.16")
  install(SCRIPT "${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/InstallRuntimeDeps.cmake")
else()
  message(WARNING "CMake < 3.16 detected: runtime dependency auto-bundling is disabled.")
endif()

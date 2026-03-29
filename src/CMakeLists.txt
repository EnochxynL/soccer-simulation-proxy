add_subdirectory(player)
add_subdirectory(coach)
add_subdirectory(trainer)

# generate shell scripts and copy them to the binary direcotry as an executable script
configure_file(
  ${PROJECT_SOURCE_DIR}/src/start.sh.in
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start.sh
  @ONLY
  )

configure_file(
  ${PROJECT_SOURCE_DIR}/src/start.ps1.in
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start.ps1
  @ONLY
  )

configure_file(
  ${PROJECT_SOURCE_DIR}/src/start-agent.sh.in
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start-agent.sh
  @ONLY
  )

configure_file(
  ${PROJECT_SOURCE_DIR}/src/start-agent.ps1.in
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start-agent.ps1
  @ONLY
  )

file(
  COPY ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start.sh
  DESTINATION ${PROJECT_BINARY_DIR}/bin
  FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  )

file(
  COPY ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start.ps1
  DESTINATION ${PROJECT_BINARY_DIR}/bin
  )

file(
  COPY ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start-agent.sh
  DESTINATION ${PROJECT_BINARY_DIR}/bin
  FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  )

file(
  COPY ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start-agent.ps1
  DESTINATION ${PROJECT_BINARY_DIR}/bin
  )

configure_file(
  ${PROJECT_SOURCE_DIR}/src/keepaway.sh.in
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/keepaway.sh
  @ONLY
  )

configure_file(
  ${PROJECT_SOURCE_DIR}/src/keepaway.ps1.in
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/keepaway.ps1
  @ONLY
  )

file(
  COPY ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/keepaway.sh
  DESTINATION ${PROJECT_BINARY_DIR}/bin
  FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  )

file(
  COPY ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/keepaway.ps1
  DESTINATION ${PROJECT_BINARY_DIR}/bin
  )

configure_file(
  ${PROJECT_SOURCE_DIR}/src/train.sh.in
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/train.sh
  @ONLY
  )

configure_file(
  ${PROJECT_SOURCE_DIR}/src/train.ps1.in
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/train.ps1
  @ONLY
  )

file(
  COPY ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/train.sh
  DESTINATION ${PROJECT_BINARY_DIR}/bin
  FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
  )

file(
  COPY ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/train.ps1
  DESTINATION ${PROJECT_BINARY_DIR}/bin
  )

configure_file(
        ${PROJECT_SOURCE_DIR}/src/player.sh.in
        ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/player.sh
        @ONLY
)

configure_file(
  ${PROJECT_SOURCE_DIR}/src/player.ps1.in
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/player.ps1
  @ONLY
)

file(
        COPY ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/player.sh
        DESTINATION ${PROJECT_BINARY_DIR}/bin
        FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
)

file(
  COPY ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/player.ps1
  DESTINATION ${PROJECT_BINARY_DIR}/bin
)

# copy other files to the binary direcotry
file(COPY
  formations-dt formations-keeper formations-taker player.conf coach.conf start-debug.sh start-offline.sh start-debug-agent.sh start-debug.ps1 start-offline.ps1 start-debug-agent.ps1
  DESTINATION ${PROJECT_BINARY_DIR}/bin
  )

file(COPY
${PROJECT_SOURCE_DIR}/idl/grpc/service.proto ${PROJECT_SOURCE_DIR}/idl/thrift/soccer_service.thrift
  DESTINATION ${PROJECT_BINARY_DIR}/bin
  )

install(PROGRAMS
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start.sh
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start-agent.sh
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/keepaway.sh
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/train.sh
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/player.sh
  DESTINATION bin
)

install(FILES
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start.ps1
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/start-agent.ps1
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/keepaway.ps1
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/train.ps1
  ${PROJECT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/player.ps1
  DESTINATION bin
)

install(FILES
  ${PROJECT_SOURCE_DIR}/src/player.conf
  ${PROJECT_SOURCE_DIR}/src/coach.conf
  ${PROJECT_SOURCE_DIR}/src/start-debug.sh
  ${PROJECT_SOURCE_DIR}/src/start-offline.sh
  ${PROJECT_SOURCE_DIR}/src/start-debug-agent.sh
  ${PROJECT_SOURCE_DIR}/src/start-debug.ps1
  ${PROJECT_SOURCE_DIR}/src/start-offline.ps1
  ${PROJECT_SOURCE_DIR}/src/start-debug-agent.ps1
  ${PROJECT_SOURCE_DIR}/idl/grpc/service.proto
  ${PROJECT_SOURCE_DIR}/idl/thrift/soccer_service.thrift
  DESTINATION bin
)

install(DIRECTORY
  ${PROJECT_SOURCE_DIR}/src/formations-dt
  ${PROJECT_SOURCE_DIR}/src/formations-keeper
  ${PROJECT_SOURCE_DIR}/src/formations-taker
  DESTINATION bin
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

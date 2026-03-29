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

if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.16")
  install(CODE [[
    set(_install_bin "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin")
    get_filename_component(_build_root "${CMAKE_CURRENT_LIST_DIR}/.." ABSOLUTE)
    set(_build_bin "${_build_root}/bin")
    set(_exe_suffix "${CMAKE_EXECUTABLE_SUFFIX}")
    if(WIN32 AND _exe_suffix STREQUAL "")
      set(_exe_suffix ".exe")
    endif()
    set(_executables
      "${_build_bin}/sample_player${_exe_suffix}"
      "${_build_bin}/sample_coach${_exe_suffix}"
      "${_build_bin}/sample_trainer${_exe_suffix}"
    )

    set(_existing_executables)
    foreach(_exe IN LISTS _executables)
      if(EXISTS "${_exe}")
        list(APPEND _existing_executables "${_exe}")
      endif()
    endforeach()

    message(STATUS "Runtime dependency scan executable candidates: ${_executables}")
    message(STATUS "Runtime dependency scan existing executables: ${_existing_executables}")

    if(_existing_executables)
      if(WIN32)
        set(_runtime_search_dirs)
        if(DEFINED ENV{MSYSTEM_PREFIX})
          list(APPEND _runtime_search_dirs "$ENV{MSYSTEM_PREFIX}/bin")
        endif()
        if(DEFINED ENV{MINGW_PREFIX})
          list(APPEND _runtime_search_dirs "$ENV{MINGW_PREFIX}/bin")
        endif()
        if(EXISTS "${LIBRCSC_LIBDIR}")
          list(APPEND _runtime_search_dirs "${LIBRCSC_LIBDIR}")
        endif()

        file(GET_RUNTIME_DEPENDENCIES
          EXECUTABLES ${_existing_executables}
          RESOLVED_DEPENDENCIES_VAR _resolved_deps
          UNRESOLVED_DEPENDENCIES_VAR _unresolved_deps
          DIRECTORIES ${_runtime_search_dirs}
          PRE_EXCLUDE_REGEXES
            "api-ms-win-.*"
            "ext-ms-.*"
          POST_EXCLUDE_REGEXES
            ".*[\\/]Windows[\\/]System32[\\/].*"
            ".*[\\/]Windows[\\/]WinSxS[\\/].*"
        )

        list(FILTER _resolved_deps INCLUDE REGEX ".*[\\/](ucrt64|mingw64|clang64|clangarm64|clang32)[\\/]bin[\\/].*\\.dll$")
      else()
        file(GET_RUNTIME_DEPENDENCIES
          EXECUTABLES ${_existing_executables}
          RESOLVED_DEPENDENCIES_VAR _resolved_deps
          UNRESOLVED_DEPENDENCIES_VAR _unresolved_deps
          POST_EXCLUDE_REGEXES
            "^/lib/.*"
            "^/lib64/.*"
            "^/usr/lib/.*"
            "^/usr/lib64/.*"
        )
      endif()

      list(REMOVE_DUPLICATES _resolved_deps)
      message(STATUS "Resolved runtime dependencies count: ${_resolved_deps}")
      foreach(_dep IN LISTS _resolved_deps)
        if(WIN32)
          file(INSTALL
            DESTINATION "${_install_bin}"
            TYPE FILE
            FILES "${_dep}"
          )
        else()
          file(INSTALL
            DESTINATION "${_install_bin}"
            TYPE SHARED_LIBRARY
            FOLLOW_SYMLINK_CHAIN
            FILES "${_dep}"
          )
        endif()
      endforeach()

      if(_unresolved_deps)
        list(REMOVE_DUPLICATES _unresolved_deps)
        message(WARNING "Unresolved runtime dependencies: ${_unresolved_deps}")
      endif()
    else()
      message(WARNING "No built executables found in ${_build_bin} for runtime dependency collection.")
    endif()
  ]])
else()
  message(WARNING "CMake < 3.16 detected: runtime dependency auto-bundling is disabled.")
endif()

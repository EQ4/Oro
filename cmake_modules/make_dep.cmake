
macro(make_dep DEP_NAME)
  set(RELATIVE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/${DEP_NAME})
  message("make_dep on ${DEP_NAME} in ${RELATIVE_DIR}")
  if(EXISTS "${RELATIVE_DIR}" AND IS_DIRECTORY "${RELATIVE_DIR}")
    if (EXISTS "${RELATIVE_DIR}/CMakeLists.txt")
      message(STATUS "Allosystem: ${DEP_NAME} sources with CMakeLists found. Building ${DEP_NAME}.")
      set(BUILDING_${DEP_NAME} 1)
      add_subdirectory(${RELATIVE_DIR} ${RELATIVE_DIR}/AlloSystem-build)
      set(INCLUDE_DIR ${RELATIVE_DIR})
      get_target_property(${DEP_NAME}_LIBRARY ${DEP_NAME} LOCATION)
      message(STATUS "${DEP_NAME} library: ${${DEP_NAME}_LIBRARY}")
    else()
      message(STATUS "Allosystem: Trying make for ${DEP_NAME}.")
      execute_process(COMMAND make WORKING_DIRECTORY "${RELATIVE_DIR}"
        RESULT_VARIABLE make_result)
      if (NOT make_result EQUAL 0)
        message("Allosystem: ${DEP_NAME} make failed. Can't build ${DEP_NAME}.")
      else()
        find_package(${DEP_NAME})
      endif(NOT make_result EQUAL 0)
    endif()
  else()
    message("Allosystem: ${DEP_NAME} sources NOT found. Can't build ${DEP_NAME}.")
  endif()
endmacro()

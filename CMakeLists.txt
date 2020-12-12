cmake_minimum_required(VERSION 3.5.0)

# scikit-build test
if(SKBUILD)
    message(STATUS "The project is built using scikit-build")
endif()

message(STATUS "The generator is: ${CMAKE_GENERATOR}")
message(STATUS "The build type is: ${CMAKE_BUILD_TYPE}")
message(STATUS "The toolchain is: ${CMAKE_TOOLCHAIN_FILE}")


# set the project name
project(mixstream)

#
# manage dependencies
#
# set vars
set(USE_VCPKG OFF CACHE BOOL "Use dependencies installed via vcpkg (not dependency package)")
set(VCPKG_APPLOCAL_DEPS ${USE_VCPKG} BOOL)

# find python deps
find_package(Python REQUIRED)
find_package(PythonExtensions REQUIRED)
find_package(Cython REQUIRED)

# get deps
if(USE_VCPKG)
    message(STATUS "Use vcpkg")
else()
    message(STATUS "Use pkgconfig")

    find_package(PkgConfig REQUIRED)
    pkg_search_module(GLIB2 REQUIRED glib-2.0 IMPORTED_TARGET)
    pkg_search_module(SOUNDTOUCH REQUIRED soundtouch-1.0 IMPORTED_TARGET)
    pkg_search_module(VORBISFILE REQUIRED vorbisfile IMPORTED_TARGET)
    find_package(SDL_mixer REQUIRED)
endif()


#
# build the project
#
add_subdirectory(mixstream)

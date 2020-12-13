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
set(_VCPKG OFF CACHE BOOL "Use dependencies installed via vcpkg (not dependency package)")
set(VCPKG_APPLOCAL_DEPS ${_VCPKG} BOOL)

# find python deps
find_package(Python REQUIRED)
find_package(PythonExtensions REQUIRED)
find_package(Cython REQUIRED)

# find system deps
if(_VCPKG)
    message(STATUS "Use vcpkg")

    # set vcpkg vars
    set(VCPKG_CRT_LINKAGE dynamic)
    set(VCPKG_LIBRARY_LINKAGE dynamic)

    # find deps
    ## glib
    find_path(GLIB2_INCLUDE_DIRS NAMES glib.h)
    find_library(GLIB2_LINK_LIBRARIES glib-2.0)
    ## gthread
    find_path(GTHREAD2_INCLUDE_DIRS NAMES glib/gthread.h)
    find_library(GTHREAD2_LINK_LIBRARIES gthread-2.0)
    ## soundtouch
    find_path(SOUNDTOUCH_INCLUDE_DIRS NAMES SoundTouch.h SoundTouchDLL.h)
    find_library(SOUNDTOUCH_LINK_LIBRARIES NAMES libsoundtouch soundtouch soundtouchdll_x64 soundtouchdll_x86 soundtouchdll)
    ## vorbisfile
    find_path(VORBISFILE_INCLUDE_DIRS NAMES vorbis/vorbisfile.h)
    find_library(VORBISFILE_LINK_LIBRARIES NAMES vorbisfile)
    ## sdl_mixer
    find_package(FindSDL_mixer)

else()
    message(STATUS "Use pkgconfig")

    find_package(PkgConfig REQUIRED)
    pkg_search_module(GLIB2 REQUIRED glib-2.0 IMPORTED_TARGET)
    pkg_search_module(GTHREAD2 REQUIRED gthread-2.0 IMPORTED_TARGET)
    pkg_search_module(SOUNDTOUCH REQUIRED soundtouch soundtouch-1.0 soundtouch-1.4 IMPORTED_TARGET)
    pkg_search_module(VORBISFILE REQUIRED vorbisfile IMPORTED_TARGET)
    find_package(SDL_mixer REQUIRED)
endif()


#
# build the project
#
add_subdirectory(mixstream)

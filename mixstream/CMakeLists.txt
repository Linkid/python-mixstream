# cythonize the pyx file
add_cython_target(_MixStream _MixStream.pyx)

# compile the extension with the lib
add_library(_MixStream MODULE ${_MixStream} MixStream.c vorbis.c soundtouch-c.cpp)
target_include_directories(_MixStream
    INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
    PRIVATE ${GLIB2_INCLUDE_DIRS}
    PRIVATE ${GTHREAD2_INCLUDE_DIRS}
    PRIVATE ${SDL_MIXER_INCLUDE_DIRS}
    PRIVATE ${SOUNDTOUCH_INCLUDE_DIRS}
)
target_link_libraries(_MixStream
    ${GLIB2_LIBRARIES}
    ${GTHREAD2_LIBRARIES}
    ${SDL_MIXER_LIBRARIES}
    ${VORBISFILE_LIBRARIES}
    ${SOUNDTOUCH_LIBRARIES}
)
python_extension_module(_MixStream)

# install the module
install(TARGETS _MixStream
    LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/mixstream
    PRIVATE_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

# Windows: copy DLLs
#if (WIN32)
#    install()
#endif()

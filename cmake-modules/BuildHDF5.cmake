macro(build_hdf5 install_prefix staging_prefix zlib_include_dir zlib_library)

get_filename_component(zlib_library_dir ${zlib_library} PATH)

ExternalProject_Add(HDF5
  SOURCE_DIR HDF5
  URL "https://www.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8.15-patch1/src/hdf5-1.8.15-patch1.tar.bz2"
  URL_MD5 "3c0d7a8c38d1abc7b40fc12c1d5f2bb8"
  BUILD_IN_SOURCE 1
  INSTALL_DIR     "${CMAKE_BINARY_DIR}/external"
  BUILD_COMMAND   $(MAKE) 
  INSTALL_COMMAND $(MAKE) DESTDIR=${CMAKE_BINARY_DIR}/external install 
  CONFIGURE_COMMAND  ./configure --prefix=${install_prefix} --with-zlib=${zlib_include_dir},${zlib_library_dir} --with-pic --disable-shared --enable-cxx --disable-f77 --disable-f90 --disable-examples --disable-hl --disable-docs --libdir=${install_prefix}/lib${LIB_SUFFIX} CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER}
#  INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/external
)

SET(HDF5_INCLUDE_DIR ${staging_prefix}/${install_prefix}/include )
SET(HDF5_LIBRARY     ${staging_prefix}/${install_prefix}/lib${LIB_SUFFIX}/libhdf5.a )
SET(HDF5_FOUND ON)

endmacro(build_hdf5)

#/usr/bin/env bash

os=$1

mkdir -p $cur__install/include
mkdir -p $cur__install/lib
mkdir -p $cur__install/bin

if [ "$os" == "windows" ]; then
  # Copy over header files
  cp -a $cur__root/curl/include/curl $cur__install/include/

  # Copy the DLL to the bin folder
  cp -a $cur__root/prebuilt/windows/cygcurl-4.dll $cur__install/bin/

  # Generate a definition file in the lib directory
  gendef.exe - $cur__install/bin/cygcurl-4.dll > $cur__install/lib/curl.def

  # Generate a lib file from the DLL
  x86_64-W64-mingw32-dlltool.exe -D $cur__install/cygcurl-4.dll -d $cur__install/lib/curl.def -A -l $cur__install/lib/libcurl.a
fi

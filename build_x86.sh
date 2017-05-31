#!/usr/bin/env bash
#source /home/juan/rti_connext_dds-5.2.3/resource/scripts/rtisetenv_x64Linux3gcc4.8.2.bash
rm -rf src/objs
rm src/*.h
rm src/*.cxx
rm src/*.xml
rm src/make*

#Generate sample codes for RTI pub-sub
cd src
rtiddsgen -replace -language C++ -example x64Linux3gcc4.8.2 ../idl/*.idl -d ./

#Add libraries from app_makefile to generated makefile (this is a hack for now)
perl -pi -e 's/INCLUDES =/INCLUDES +=/g' makefile*
perl -pi -e 's/COMMONSOURCES =/COMMONSOURCES +=/g' makefile*

make -f  app_makefile


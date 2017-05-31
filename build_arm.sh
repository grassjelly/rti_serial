#!/usr/bin/env bash
#source /home/juan/rti_connext_dds-5.2.3/resource/scripts/rtisetenv_armv6vfphLinux3.xgcc4.7.2.bash
rm -rf src/objs
rm src/*.h
rm src/*.cxx
rm src/*.xml
rm src/make*

#Generate sample codes for RTI pub-sub
cd src
rtiddsgen -replace -language C++ -example armv6vfphLinux3.xgcc4.7.2 ../idl/*.idl -d ./

#Change makefile from default -march=armv6 to -march=armv7-a (tested on beaglebone and nanopi neo/air)
perl -pi -e 's/-march=armv6/-march=armv7-a/g' makefile*
perl -pi -e 's/LINKER_FLAGS =/LINKER_FLAGS = -std=c++11/g' makefile*

#Add libraries from app_makefile to generated makefile (this is a hack for now)
perl -pi -e 's/INCLUDES =/INCLUDES +=/g' makefile*
perl -pi -e 's/COMMONSOURCES =/COMMONSOURCES +=/g' makefile*

make -f app_makefile
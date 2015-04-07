#!/bin/bash

set -e
cd $(dirname "${BASH_SOURCE[0]}")





exit


################################################

mkdir -p build/armv7 && cd build/armv7
../../configure \
--cc=`xcrun -f --sdk iphoneos8.2 clang` \
--arch=armv7 \
--cpu=cortex-a8 \
--sysroot=`xcrun --sdk iphoneos8.2 --show-sdk-path` \
--target-os=darwin \
--extra-cflags='-arch armv7 -Wno-asm-operand-widths -integrated-as' \
--extra-ldflags='-arch armv7 -miphoneos-version-min=5.1' \
--enable-cross-compile --enable-pic \
--disable-programs

make -j6
cd ../../

################################################

mkdir -p build/arm64 && cd build/arm64
../../configure \
--cc=`xcrun -f --sdk iphoneos8.2 clang` \
--arch=aarch64 \
--cpu=generic \
--sysroot=`xcrun --sdk iphoneos8.2 --show-sdk-path` \
--target-os=darwin \
--extra-cflags='-arch arm64' \
--extra-ldflags='-arch arm64 -miphoneos-version-min=7.0' \
--enable-cross-compile \
--disable-programs

make -j6
cd ../../

################################################

mkdir -p build/x86 && cd build/x86
../../configure \
--cc=`xcrun -f --sdk iphonesimulator8.2 clang` \
--arch=x86 \
--cpu=generic \
--sysroot=`xcrun --sdk iphonesimulator8.2 --show-sdk-path` \
--target-os=darwin \
--extra-cflags='-arch i386' \
--extra-ldflags='-arch i386 -miphoneos-version-min=7.0' \
--enable-cross-compile \
--disable-programs

make -j6
cd ../../

################################################

mkdir -p build/x86_64 && cd build/x86_64
../../configure \
--arch=x86_64 \
--cpu=generic \
--sysroot=`xcrun --sdk iphonesimulator8.2 --show-sdk-path` \
--target-os=darwin \
--extra-cflags='-arch x86_64' \
--extra-ldflags='-arch x86_64 -miphoneos-version-min=7.0' \
--enable-cross-compile \
--disable-programs

make -j6
cd ../../

################################################





exit



# echo Configure for armv7 build
# ./configure \
# --cc=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/gcc \
# --as='/usr/local/bin/gas-preprocessor.pl /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/gcc' \
# --sysroot=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.0.sdk \
# --target-os=darwin \
# --arch=arm \
# --cpu=cortex-a8 \
# --extra-cflags='-arch armv7' \
# --extra-ldflags='-arch armv7 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.0.sdk' \
# --prefix=compiled/armv7 \
# --enable-cross-compile \
# --enable-nonfree \
# --enable-gpl \
# --enable-encoder=mpeg1video \
# --enable-encoder=mpeg4 \
# --disable-armv5te \
# --disable-swscale-alpha \
# --disable-doc \
# --disable-ffmpeg \
# --disable-avplay \
# --disable-avprobe \
# --disable-avserver \
# --disable-asm \
# --disable-debug


exit

make clean
make && make install


echo Configure for i386
./configure \
--cc=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/usr/bin/gcc \
--as='/usr/local/bin/gas-preprocessor.pl /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/usr/bin/gcc' \
--sysroot=/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.0.sdk \
--target-os=darwin \
--arch=i386 \
--cpu=i386 \
--extra-cflags='-arch i386' \
--extra-ldflags='-arch i386 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.0.sdk' \
--prefix=compiled/i386 \
--enable-cross-compile \
--enable-nonfree \
--enable-gpl \
--enable-encoder=mpeg1video \
--enable-encoder=mpeg4 \
--disable-armv5te \
--disable-swscale-alpha \
--disable-doc \
--disable-ffmpeg \
--disable-avplay \
--disable-avprobe \
--disable-avserver \
--disable-asm \
--disable-debug

make clean
make && make install


# make fat (universal) libs
mkdir -p ./compiled/fat/lib

xcrun -sdk iphoneos lipo -output ./compiled/fat/lib/libavcodec.a  -create \
-arch armv7 ./compiled/armv7/lib/libavcodec.a \
-arch i386 ./compiled/i386/lib/libavcodec.a

xcrun -sdk iphoneos lipo -output ./compiled/fat/lib/libavdevice.a  -create \
-arch armv7 ./compiled/armv7/lib/libavdevice.a \
-arch i386 ./compiled/i386/lib/libavdevice.a

xcrun -sdk iphoneos lipo -output ./compiled/fat/lib/libavformat.a  -create \
-arch armv7 ./compiled/armv7/lib/libavformat.a \
-arch i386 ./compiled/i386/lib/libavformat.a

xcrun -sdk iphoneos lipo -output ./compiled/fat/lib/libavutil.a  -create \
-arch armv7 ./compiled/armv7/lib/libavutil.a \
-arch i386 ./compiled/i386/lib/libavutil.a

xcrun -sdk iphoneos lipo -output ./compiled/fat/lib/libswscale.a  -create \
-arch armv7 ./compiled/armv7/lib/libswscale.a \
-arch i386 ./compiled/i386/lib/libswscale.a

xcrun -sdk iphoneos lipo -output ./compiled/fat/lib/libavfilter.a  -create \
-arch armv7 ./compiled/armv7/lib/libavfilter.a \
-arch i386 ./compiled/i386/lib/libavfilter.a
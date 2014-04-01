#!/usr/bin/env bash

echo "--- Installing FFMPEG ---"

# There is a package for ffmpeg, but it does not support x264 so we would compile
# sudo add-apt-repository ppa:samrog131/ppa
# sudo apt-get update
# sudo apt-get install -y ffmpeg

sudo apt-get remove -y ffmpeg x264 libx264-dev
sudo add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ saucy universe multiverse"
sudo add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ saucy-updates universe multiverse"
sudo apt-get update

# Get the Dependencies
sudo apt-get -y install autoconf automake build-essential git libgpac-dev \
  libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libx11-dev \
  libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev

mkdir ~/ffmpeg_sources

# Yasm
cd ~/ffmpeg_sources
wget http://www.tortall.net/projects/yasm/releases/yasm-1.2.0.tar.gz
tar xzvf yasm-1.2.0.tar.gz
cd yasm-1.2.0
sudo ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"
sudo make
sudo make install
sudo make distclean
. ~/.profile

# x264
cd ~/ffmpeg_sources
git clone --depth 1 git://git.videolan.org/x264.git
cd x264
sudo ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static
sudo make
sudo make install
sudo make distclean

# fdk-aac
cd ~/ffmpeg_sources
git clone --depth 1 git://git.code.sf.net/p/opencore-amr/fdk-aac
cd fdk-aac
autoreconf -fiv
sudo ./configure --prefix="$HOME/ffmpeg_build" --disable-shared
sudo make
sudo make install
sudo make distclean

# libmp3lame
sudo apt-get -y install libmp3lame-dev

# libvpx
cd ~/ffmpeg_sources
git clone --depth 1 http://git.chromium.org/webm/libvpx.git
cd libvpx
sudo ./configure --prefix="$HOME/ffmpeg_build" --disable-examples
sudo make
sudo make install
sudo make clean

# ffmpeg
# --enable-libass --enable-libopus not included

cd ~/ffmpeg_sources
git clone --depth 1 git://source.ffmpeg.org/ffmpeg
cd ffmpeg
PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig"
export PKG_CONFIG_PATH
sudo ./configure --prefix="$HOME/ffmpeg_build" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --bindir="$HOME/bin" --extra-libs="-ldl" --enable-gpl --enable-libfdk-aac \
  --enable-libmp3lame --enable-libtheora --enable-libvorbis --enable-libvpx \
  --enable-libx264 --enable-nonfree
sudo make
sudo make install
sudo make distclean
hash -r
. ~/.profile

# yes | sudo cp -rf ~/ffmpeg_sources/ffmpeg/ffmpeg /usr/bin/ffmpeg

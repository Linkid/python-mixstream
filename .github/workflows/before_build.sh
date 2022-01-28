#!/bin/bash
# before build

set -e
set -x

# get the operating system
operating_system=$(echo "$1" | tr '[:upper:]' '[:lower:]')
echo "[+] Operating system: " ${operating_system}

# install system dependencies
case ${operating_system} in

    "ubuntu"*)
        echo "[*] Info: `cat /proc/version`"
        echo "`cat /etc/redhat-release`"
        echo "apt: `which apt`"
        echo "apt-get: `which apt-get`"
        echo "yum: `which yum`"
        #apt-get install libglib2.0-dev libvorbis-dev libportmidi-dev libsdl-mixer1.2-dev

        yum -y install \
            portmidi-devel \
            SDL_mixer-devel \
            soundtouch-devel \
            libvorbis-devel
    ;;
    "macos"*)
        echo "[*] osx"
        brew update --quiet > /dev/null
        brew install --quiet \
            glib \
            libvorbis \
            portmidi \
            sdl_mixer \
            sound-touch
    ;;

    "windows"*)
        echo "[*] windows"
        echo "- cibw_build: ${CIBW_BUILD}"
        echo "- cibw_arch: ${CIBW_ARCH}"

        if [[ $( echo ${CIBW_BUILD} | grep win32 ) ]]
        then
            export VCPKG_DEFAULT_TRIPLET=x86-windows
        else
            export VCPKG_DEFAULT_TRIPLET=x64-windows
        fi

        echo "VCPKG_ROOT: .${VCPKG_ROOT}."
        ${VCPKG_ROOT}/vcpkg install \
            glib \
            libvorbis \
            portmidi \
            sdl1 \
            soundtouch --clean-after-build

        echo "[*] integrate"
        ${VCPKG_ROOT}/vcpkg integrate install

        #echo "[*] download SDL_mixer"
        #curl -LO https://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-devel-1.2.12-VC.zip
        #unzip SDL_mixer-devel-1.2.12-VC.zip
    ;;

    *)
        echo "[*] no OS: " ${operating_system}
    ;;
esac

# install python dependencies
echo "[+] Install python dependencies"
pip install cython scikit-build cmake ninja
pip install -U wheel

echo "[+] All done"

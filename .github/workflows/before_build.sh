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
        #apt-get install libglib2.0-dev libvorbis-dev libportmidi-dev libsdl2-mixer-dev

        yum -y install \
            portmidi-devel \
            SDL2_mixer-devel \
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
            sdl2_mixer \
            sound-touch
    ;;
    "windows"*)
        echo "[*] windows"
        echo "- cibw_build: ${CIBW_BUILD}"
        echo "- cibw_arch: ${CIBW_ARCH}"

        echo "VCPKG_ROOT: .${VCPKG_ROOT}."
        ${VCPKG_ROOT}/vcpkg install \
            glib \
            libvorbis \
            portmidi \
            sdl2-mixer \
            soundtouch --clean-after-build

        echo "[*] integrate"
        ${VCPKG_ROOT}/vcpkg integrate install

    ;;
    *)
        echo "[*] not supported OS: " ${operating_system}
    ;;
esac

# install python dependencies
echo "[+] Install python dependencies"
pip install cython scikit-build cmake ninja
pip install -U wheel

echo "[+] All done"

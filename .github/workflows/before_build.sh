#!/bin/bash
# before build

# get the operating system
operating_system=$(echo "$1" | tr '[:upper:]' '[:lower:]')

# install system dependencies
echo "[+] Operating system: " ${operating_system}
case ${operating_system} in

    "ubuntu"*)
        echo "[*] Add EPEL repo"
        if [[ $( grep "release 5" /etc/redhat-release ) ]]
        then
            rpm -Uvh
            https://archives.fedoraproject.org/pub/archive/epel/5/i386/epel-release-5-4.noarch.rpm
        elif [[ $( grep "release 6" /etc/redhat-release ) ]]
        then
            rpm -Uvh https://archives.fedoraproject.org/pub/archive/epel/6/i386/epel-release-6-8.noarch.rpm
        elif [[ $( grep "release 7" /etc/redhat-release ) ]]
        then
            rpm -Uvh https://download-ib01.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
        else
            echo "[+] EPEL repo not found"
            cat /etc/redhat-release
        fi

        echo "[*] Install RPM packages"
        yum -y install \
            portmidi-devel \
            SDL_mixer-devel \
            soundtouch-devel \
            libvorbis-devel
    ;;

    "macos"*)
        # macos
        echo "[*] osx"
        brew update --quiet > /dev/null
        brew install --quiet \
            glib \
            portmidi \
            libvorbis \
            sdl_mixer \
            sound-touch
    ;;

    "windows"*)
        # windows
        echo "[*] windows"

        if [[ $( echo ${CIBW_BUILD} | grep win32 ) ]]
        then
            export VCPKG_DEFAULT_TRIPLET=x86-windows
        else
            export VCPKG_DEFAULT_TRIPLET=x64-windows
        fi

        vcpkg install \
            glib \
            libvorbis \
            portmidi \
            sdl1 \
            soundtouch
        echo "[*] integrate"
        vcpkg integrate install

        echo "[*] download SDL_mixer"
        wget https://www.libsdl.org/projects/SDL_mixer/release/SDL_mixer-devel-1.2.12-VC.zip
        unzip SDL_mixer-devel-1.2.12-VC.zip
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

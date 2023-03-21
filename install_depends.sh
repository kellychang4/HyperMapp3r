#!/usr/bin/env bash

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
echo "Adding external dependencies to ${SCRIPT_PATH}"

# create depends dir
mkdir -p "${SCRIPT_PATH}/depends/"

# find out if the user has ANTS installed
ants_path=$( command -v antsRegistration )
if [[ -z "${ants_path}" ]]; then
	echo "ANTs was not found." 
    echo "Downloading and installing software to ${SCRIPT_PATH}/depends/ANTs."
    echo "Path will be added to PATH environment variable."
    ants_depends="${SCRIPT_PATH}/depends/ANTs"
    mkdir -p "${ants_depends}" && \
    curl -sL "https://github.com/ANTsX/ANTs/releases/download/v2.4.3/ants-2.4.3-ubuntu-22.04-X64-gcc.zip" | \
        tar -xzC "${ants_depends}" --strip-components 1     
    export PATH="${ants_depends}/bin:${PATH}"   
fi

# find out if user has c3d installed
c3d_path=$( command -v c3d )
if [[ -z "${c3d_path}" ]]; then
	echo "Command c3d was not found."
    echo "Downloading and installing software to ${SCRIPT_PATH}/depends/c3d."
    echo "Path will be added to PATH environment variable."
    c3d_depends="${SCRIPT_PATH}/depends/c3d"
    mkdir -p "${c3d_depends}" && \
    curl -sL "https://downloads.sourceforge.net/project/c3d/c3d/Nightly/c3d-nightly-Linux-x86_64.tar.gz" | \
        tar -xzC "c3d" --strip-components 1
    export PATH="${c3d_depends}/bin:${PATH}"
fi

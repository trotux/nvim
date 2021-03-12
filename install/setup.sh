#!/usr/bin/env bash

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

LSB_RELEASE_FILE=$(which lsb_release 2> /dev/null || true)
echo "LSB_RELEASE_FILE: ${LSB_RELEASE_FILE}"

if [ -z "${LSB_RELEASE_FILE:-}" ]; then
   echo "Unknown linux distrib, exit"
   exit 0
fi

DISTRIB_ID=`lsb_release -si`
DISTRIB_RELEASE=`lsb_release -sr`
DISTRIB_CODENAME=`lsb_release -sc`
DISTRIB_DESCRIPTION=`lsb_release -sd`

echo DISTRIB_ID: $DISTRIB_ID
echo DISTRIB_RELEASE: $DISTRIB_RELEASE
echo DISTRIB_CODENAME: $DISTRIB_CODENAME
echo DISTRIB_DESCRIPTION: $DISTRIB_DESCRIPTION

USER_ID=$(id -u)
SUDO=

if [ ${USER_ID} -ne 0 ]; then
    SUDO=sudo
fi

HOME_PATH="${HOME}"
echo "HOME_PATH: ${HOME_PATH}"
BUILD_PATH="${HOME_PATH}/build"
echo "BUILD_PATH: ${BUILD_PATH}"

add_llvm_sources_list() {
    echo "deb http://apt.llvm.org/${DISTRIB_CODENAME}/ llvm-toolchain-${DISTRIB_CODENAME}-11 main" > /tmp/llvm.list
    echo "deb-src http://apt.llvm.org/${DISTRIB_CODENAME}/ llvm-toolchain-${DISTRIB_CODENAME}-11 main" >> /tmp/llvm.list
    ${SUDO} cp /tmp/llvm.list /etc/apt/sources.list.d
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | ${SUDO} apt-key add -
}

install_deps_for_debian_like() {
    if [ "${DISTRIB_ID}" == "Debian" ]; then
        add_llvm_sources_list
    elif [ "${DISTRIB_ID}" == "Ubuntu" ]; then
        add_llvm_sources_list
    else
        exit 1
    fi

    ${SUDO} apt-get update
    ${SUDO} apt-get install -y \
        curl \
        python3-pip \
        editorconfig \
        exuberant-ctags \
        silversearcher-ag \
        clang-11 \
        clang-format-11 \
        libclang-11-dev \
        llvm-11-dev \
        rapidjson-dev \
        nodejs \
        pkg-config \
        libtool \
        libtool-bin \
        gettext \
        zlib1g-dev \
        libuv1-dev \
        lua-luv-dev \
        lua5.1 \
        luarocks \
        git \
        cmake \
        ninja-build \
        npm

    #Python backend for Neovim
    pip3 install setuptools
    pip3 install --upgrade pynvim
    pip3 install neovim-remote

    ${SUDO} update-alternatives --remove-all clang || true
    ${SUDO} update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-11 100
    ${SUDO} update-alternatives --install /usr/bin/clang clang /usr/bin/clang-11 100
    ${SUDO} update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-11 100
    ${SUDO} update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-11 100
}

install_ccls_from_sources() {
    [ ! -d ${BUILD_PATH} ] && mkdir -p ${BUILD_PATH}
    cd ${BUILD_PATH} || exit
    if [ ! -e ${BUILD_PATH}/ccls ]; then
        git clone https://github.com/MaskRay/ccls.git
    fi

    cd ${BUILD_PATH}/ccls || exit
    git checkout master && git pull

    #Remove old build dir and .deps dir
    rm -rf build/
    rm -rf .deps/

    cmake -GNinja -H. -Bbuild -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_PREFIX_PATH=/usr/lib/llvm-11
    ninja -C build
    ${SUDO} ninja -C build install
}

install_ccls_for_debian_like() {
    ${SUDO} apt-get install -y ccls
}

install_neovim_from_sources() {
    # Enable use of python plugins
    # Note: python neovim module was renamed to pynvim
    # https://github.com/neovim/neovim/wiki/Following-HEAD#steps-to-update-pynvim-formerly-neovim-python-package

    #Get or update neovim github repo
    [ ! -d ${BUILD_PATH} ] && mkdir -p ${BUILD_PATH}
    cd ${BUILD_PATH} || exit
    if [ ! -e ${BUILD_PATH}/neovim ]; then
        git clone --single-branch --branch release-0.4 https://github.com/neovim/neovim
    fi

    cd ${BUILD_PATH}/neovim || exit

    #Remove old build dir and .deps dir
    rm -rf build/
    rm -rf .deps/
    make distclean

    # Build and install neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/local/"
    ${SUDO} make install
}

install_neovim_for_debian_like() {
    ${SUDO} apt-get install -y neovim
}

setup_neovim() {
    mv ${HOME}/.config/nvim/init.vim ${HOME}/.config/nvim/init.vim.tmp
    mv ${HOME}/.config/nvim/install/init.vim ${HOME}/.config/nvim/init.vim

    echo "Installing plugins..."
    nvim --headless +PlugClean +PlugInstall +qall > /dev/null 2>&1
    mv ${HOME}/.config/nvim/init.vim ${HOME}/.config/nvim/install/init.vim
    mv ${HOME}/.config/nvim/init.vim.tmp ${HOME}/.config/nvim/init.vim
}

move_old_neovim_confug() {
  echo "Moving your config to nvim.old"
  mv ${HOME}/.config/nvim ${HOME}/.config/nvim.old
}

clone_neovim_config() {
    # move old nvim directory if it exists
    [ -d "$HOME/.config/nvim" ] && move_old_neovim_confug
    git clone https://github.com/trotux/nvim ${HOME}/.config/nvim
}

install_coc_extensions() {
    #Nodejs backend for Neovim
    if [ ! -z "${http_proxy:-}" ]; then
        npm config set https-proxy ${http_proxy}
        npm config set proxy ${http_proxy}
    fi

#    npm config set loglevel verbose
    ${SUDO} -E npm i -g neovim bash-language-server diff-so-fancy

    # Install extensions
    mkdir -p ~/.config/coc/extensions
    cd ~/.config/coc/extensions
    [ ! -f package.json ] && echo '{"dependencies":{}}'> package.json
    # Change extension names to the extensions you need
    npm install coc-explorer coc-snippets coc-json coc-actions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
}

install_packages() {
    if [ "${DISTRIB_ID}" == "Debian" ]; then
        install_deps_for_debian_like
        install_ccls_from_sources
        install_neovim_from_sources
    elif [ "${DISTRIB_ID}" == "Ubuntu" ]; then
        install_deps_for_debian_like
        install_ccls_from_sources
        if [ "${DISTRIB_RELEASE}" == "18.04" ]; then
            install_neovim_from_sources
        else
            install_neovim_for_debian_like
        fi
    else
        echo "Unknown OS, exit"
        exit 1
    fi
}

#Save current dir
pushd . > /dev/null || exit

install_packages
clone_neovim_config
setup_neovim
install_coc_extensions

#Restore dir
popd > /dev/null || exit

echo "nvim command: $(command -v nvim)"
echo "nvim command: $(ls -al "$(command -v nvim)")"

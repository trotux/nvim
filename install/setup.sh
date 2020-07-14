#!/usr/bin/env bash

if [ -f "/etc/issue" ]; then
  OS_NAME=`cat /etc/issue | grep -e Debian -e Ubuntu | sed 's/\s\+/ /g' | cut -d' ' -f1`
fi

USER_ID=$(id -u)
SUDO=

if [ ${USER_ID} -ne 0 ]; then
    SUDO=sudo
fi

HOME_PATH="${HOME}"
echo "HOME_PATH: ${HOME_PATH}"
BUILD_PATH="${HOME_PATH}/build"
echo "BUILD_PATH: ${BUILD_PATH}"
echo "Os name: ${OS_NAME}"

install_deps_for_debian() {
    ${SUDO} apt-get update
    ${SUDO} apt-get install -y \
        python-pip \
        python3-pip \
        editorconfig \
        exuberant-ctags \
        silversearcher-ag \
        clang \
        libclang-dev \
        llvm-dev \
        rapidjson-dev \
        nodejs \
        npm

    #Python backend for Neovim
    pip install setuptools
    pip install --upgrade pynvim
    pip3 install setuptools
    pip3 install --upgrade pynvim
#    pip install neovim-remote
    pip3 install neovim-remote
}

install_ccls_for_debian() {
    cd ${BUILD_PATH} || exit
    if [ ! -e ${BUILD_PATH}/ccls ]; then
        git clone https://github.com/MaskRay/ccls.git
    else
        cd ccls || exit
        git fetch origin
    fi

    cd ${BUILD_PATH}/ccls || exit
    if [ "${OS_NAME}" == "Debian" ]; then
#        git checkout master
        git reset --hard 0.20190823.6
    else
        git reset --hard 0.20190823.6
    fi

    #Remove old build dir and .deps dir
    rm -rf build/
    rm -rf .deps/

    cmake -GNinja -H. -Bbuild -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_PREFIX_PATH=/usr/lib/llvm-10
#    cmake --build Release
    ninja -C build
    ${SUDO} ninja -C build install
}

install_coc_extensions() {
    #Nodejs backend for Neovim
    if [ -z "${http_proxy}" ]; then
        npm config set https-proxy ${http_proxy}
        npm config set proxy ${http_proxy}
    fi
#    npm config set loglevel verbose
    ${SUDO} -E npm i -g neovim bash-language-server

    # Install extensions
    mkdir -p ~/.config/coc/extensions
    cd ~/.config/coc/extensions
    [ ! -f package.json ] && echo '{"dependencies":{}}'> package.json
    # Change extension names to the extensions you need
    # sudo npm install coc-explorer coc-snippets coc-json coc-actions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
    # npm install coc-explorer coc-snippets coc-json coc-actions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
}

install_neovim_for_debian() {
    # Enable use of python plugins
    # Note: python neovim module was renamed to pynvim
    # https://github.com/neovim/neovim/wiki/Following-HEAD#steps-to-update-pynvim-formerly-neovim-python-package

    #Get or update neovim github repo
    cd ${BUILD_PATH} || exit
    if [ ! -e ${BUILD_PATH}/neovim ]; then
        git clone --depth 1 https://github.com/neovim/neovim
    else
        cd neovim || exit
        git fetch origin
    fi

    cd ${BUILD_PATH}/neovim || exit
    git checkout master

    #Remove old build dir and .deps dir
    rm -rf build/
    rm -rf .deps/
    make distclean

    # Build and install neovim
    make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/local/"
    ${SUDO} make install
}

install_deps_for_ubuntu() {
    ${SUDO} apt-get update
    ${SUDO} apt-get install -y \
        python-pip \
        python3-pip \
        editorconfig \
        exuberant-ctags \
        silversearcher-ag \
        clang \
        libclang-dev \
        llvm-dev \
        rapidjson-dev \
        nodejs \
        npm

    #Python backend for Neovim 
    pip install setuptools
    pip install --upgrade pynvim
    pip3 install setuptools
    pip3 install --upgrade pynvim
#    pip install neovim-remote
    pip3 install neovim-remote
}

install_ccls_for_ubuntu() {
    cd ${BUILD_PATH} || exit
    if [ ! -e ${BUILD_PATH}/ccls ]; then
        git clone https://github.com/MaskRay/ccls.git
    else
        cd ccls || exit
        git fetch origin
    fi

    cd ${BUILD_PATH}/ccls || exit
    if [ "${OS_NAME}" == "Debian" ]; then
#        git checkout master
        git reset --hard 0.20190823.6
    else
        git reset --hard 0.20190823.6
    fi

    #Remove old build dir and .deps dir
    rm -rf build/
    rm -rf .deps/

    cmake -GNinja -H. -Bbuild -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_PREFIX_PATH=/usr/lib/llvm-10
#    cmake --build Release
    ninja -C build
    ${SUDO} ninja -C build install
}

install_neovim_for_ubuntu() {
    ${SUDO} apt install neovim
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

install_deps() {
    if [ "${OS_NAME}" == "Debian" ]; then
        install_deps_for_debian
        install_ccls_for_debian
    elif [ "${OS_NAME}" == "Ubuntu" ]; then
        install_deps_for_ubuntu
        install_ccls_for_ubuntu
    else
        echo "Unknown OS, exit"
        exit 1
    fi
}

install_neovim() {
    if [ "${OS_NAME}" == "Debian" ]; then
        install_neovim_for_debian
    elif [ "${OS_NAME}" == "Ubuntu" ]; then
        install_neovim_for_ubuntu
    else
        echo "Unknown OS, exit"
        exit 1
    fi
}

#Save current dir
pushd . > /dev/null || exit

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

mkdir -p ${BUILD_PATH}

install_deps
install_neovim
clone_neovim_config
setup_neovim
install_coc_extensions

#Restore dir
popd > /dev/null || exit

echo "nvim command: $(command -v nvim)"
echo "nvim command: $(ls -al "$(command -v nvim)")"

#!/usr/bin/env bash
# Installation script for Ubuntu 22.04 LTS (Jammy Jellyfish)

TMP_DIR=.tmp-dotfiles

function put {
  local YELLOW='\033[1;33m'
  local NC='\033[0m' # No Color
  printf "${YELLOW}$@${NC}\n"
}

# Create temp dir
[ -d temp ] || mkdir ${TMP_DIR}
cd ${TMP_DIR}



# Update cache
sudo apt update



# Install basic tools and extensions
# apt-file - Provides an easy way to find the binary package that contains a given file
put "Installing basic tools and extensions"
sudo apt -y install \
  texinfo \
  curl wget rsync \
  gnupg \
  unzip \
  vim \
  git \
  aptitude \
  apt-transport-https \
  apt-file



# Install the google's apt repository and signing key
if [ ! -e "/etc/apt/sources.list.d/google-chrome.list" ]; then
  wget -qO - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
else
  put "google's repository already installed"
fi

# Install the vscode's apt repository and signing key
if [ ! -e "/etc/apt/sources.list.d/vscode.list" ]; then
  wget -qO - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
else
  put "vscode's repository already installed"
fi

# Update the repositories cache
sudo apt update

# code and chrome
put "Installing 'code' and 'chrome'"
sudo apt -y install \
  code \
  google-chrome-stable



# vscode extensions
put "Installing vscode extensions"
sudo -u ${SUDO_USER} code --install-extension shardulm94.trailing-spaces
sudo -u ${SUDO_USER} code --install-extension jinsihou.diff-tool



# deb-get and 3rd party packages
# see: https://github.com/wimpysworld/deb-get
put "Installing 'deb-get' and 3rd party packages"
# deb-get - apt-get functionality for .debs published in 3rd party repositories or via direct download
curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get

# Discord
sudo deb-get install \
  discord
# Franz - A messaging app for WhatsApp, Facebook Messenger, Slack, Telegram and many more.
sudo deb-get install \
  franz
# DBeaver - Database GUI Client
sudo deb-get install \
  dbeaver-ce



put "Installing dev tools"

# libc, binutils, gcc, g++ and make
sudo apt -y install \
  build-essential

# ccache - It is a compiler cache. It speeds up recompilation by caching previous compilations and detecting when the same compilation is being done again.
sudo apt -y install \
  ccache

# gdb
sudo apt -y install \
  gdb

# autotools
sudo apt -y install \
  autoconf automake libtool gnulib

# autotools config scripts
# /usr/bin/dh_autotools-dev_restoreconfig, /usr/bin/dh_autotools-dev_updateconfig,
# /usr/share/misc/config.guess and /usr/share/misc/config.sub
sudo apt -y install \
  autotools-dev

# cmake
sudo apt -y install \
  ninja-build cmake

# gettext
sudo apt -y install \
  gettext

# a hex editor
sudo apt -y install \
  hexedit

# nasm
sudo apt -y install \
  nasm

# dev docs
sudo apt -y install \
  manpages-dev glibc-doc binutils-doc gcc-doc gdb-doc

# dh_make + debhelper (dh) + dh_autoreconf
sudo apt -y install \
  dh-make

# devscripts + dput + lintian + quilt + other ubuntu dev tools
sudo apt -y install \
  ubuntu-dev-tools

# git-build-recipe - for testing Launchpad's recipes
sudo apt -y install \
  git-build-recipe

# pbuilder
# sudo apt -y install \
#   pbuilder

# bzr + debian plugins
# sudo apt -y install \
#   brz-debian



# Emulation and OS development tools
# e2fsprogs - ext2/ext3/ext4 file system utilities
# genext2fs - ext2 filesystem generator for embedded systems
# mtools - Tools for manipulating MSDOS files
# xorriso - ISO manipulation tool
# qemu-utils - QEMU utilities
# qemu-system-* - QEMU full system emulation binaries
# put "Installing qemu and OS dev tools"
# sudo apt -y install \
#   e2fsprogs genext2fs mtools \
#   xorriso \
#   qemu-system-x86 qemu-system-arm qemu-utils



# Dev libs
# libgmp-dev - Multiprecision arithmetic library developers tools
# libmpfr-dev - Multiple precision floating-point computation developers tools
# libmpc-dev - Multiple precision complex floating-point library development package
# put "Installing dev libs"
# sudo apt -y install \
#   libgmp-dev libmpfr-dev libmpc-dev



# dotnet

# Add the Microsoft package signing key to your list of trusted keys and add the package repository
# see: https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu
# wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
# sudo dpkg -i packages-microsoft-prod.deb
# rm packages-microsoft-prod.deb

# Install the SDK
# sudo apt update
# sudo apt install -y dotnet-sdk-6.0



# Remove no longer required packages
sudo apt -y autoremove



# Remove temp dir
cd ..
rm -rf "${TMP_DIR}"

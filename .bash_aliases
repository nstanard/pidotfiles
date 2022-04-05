# Sys
alias sys="uname -a"
alias update="sudo apt update"
alias upgrade="sudo apt full-upgrade"
alias upclean="sudo apt clean"
alias uprem="sudo apt autoremove"

alias restart="sudo reboot"

alias reload="source ~/.bashrc"

alias c="clear"

# Neovim
alias installneovim="sudo apt-get install neovim"

# RVM
alias installrvm="\curl -sSL https://get.rvm.io | bash -s stable --ruby"
source /home/pi/.rvm/scripts/rvm
# rvm install 2.6.8

# Homebrew
# !! This plus rvm 2.6.8 worked -> https://docs.brew.sh/Installation#untar-anywhere
# https://docs.brew.sh/Installation
# https://github.com/Homebrew/brew
# https://brew.sh/
# https://docs.brew.sh/Homebrew-on-Linux#install
# https://github.com/Homebrew/brew/issues/11320
alias brewblah="brew update --force --quiet"

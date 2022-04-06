# https://www.raspberrypi.com/documentation/accessories/camera.html

# Sys
alias sys="uname -a"
alias rconfig="sudo raspi-config"
alias update="sudo apt update"
alias upgrade="sudo apt full-upgrade"
alias upclean="sudo apt clean"
alias uprem="sudo apt autoremove"

alias restart="sudo reboot"

alias reload="source ~/.bashrc"

alias c="clear"

# Neovim
alias installneovim="sudo apt-get install neovim"
alias installcurl="sudo apt install curl"

# RVM
alias installrvm="\curl -sSL https://get.rvm.io | bash -s stable --ruby"
source ~/.rvm/scripts/rvm
# rvm install 2.6.8

# list aliases
alias commands="grep -in --color -e '^alias\s+*' ~/.bash_aliases | sed 's/alias //' | grep --color -e ':[a-z][a-z0-9]*'"

alias installmotion="sudo apt-get install motion -y"

alias listusb="lsusb"

alias listvideo="ls /dev/video*"

# https://raspberrypi.stackexchange.com/questions/118881/how-to-install-the-latest-version-of-neovim

alias installsnap="sudo apt install snapd"
alias installnewerneovim="sudo snap install --classic nvim"

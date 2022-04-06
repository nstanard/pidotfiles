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
alias installcurl="sudo apt install curl"

# RVM
alias installrvm="\curl -sSL https://get.rvm.io | bash -s stable --ruby"
# source /home/pi/.rvm/scripts/rvm
# rvm install 2.6.8

# list aliases
alias commands="grep -in --color -e '^alias\s+*' ~/.bash_aliases | sed 's/alias //' | grep --color -e ':[a-z][a-z0-9]*'"

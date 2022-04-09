# https://www.raspberrypi.com/documentation/accessories/camera.html

# easily add to $PATH
pathmunge () {
    if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)"; then
        if [ "$2" = "after" ] ; then
            PATH="$PATH:$1"
        else
            PATH="$1:$PATH"
        fi
    fi
}

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
#pathmunge "/snap/bin"

alias installnvchad="git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
nvim +'hi NormalFloat guibg=#1e222a' +PackerSync"

setupNvchad () {
  installsnap
  installnewerneovim
  installnvchad
  echo "alias vi=\"nvim\"" >> ~/.bash_aliases
}

# Nerd fonts
installNerdFonts () {
 mkdir -p ~/Development
 cd ~/Development
 
 if [ ! -d "./nerd-fonts" ] ; then
   git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git
 fi 

 cd nerd-fonts

 ./install.sh SpaceMono
}

alias camstart="libcamera-vid -t 0 --width 1080 --height 720 -q 100 -n --codec mjpeg --inline --listen -o tcp://0.0.0.0:8888 -v"
alias camlisten="ffplay tcp://0.0.0.0:8888 -vf \"setpts=N/30\" -fflags nobuffer -flags low_delay -framedrop"


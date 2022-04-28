# https://www.raspberrypi.com/documentation/accessories/camera.html

pathmunge () {
    if ! echo "$PATH" | grep -Eq "(^|:)$1($|:)"; then
        if [ "$2" = "after" ] ; then
            PATH="$PATH:$1"
        else
            PATH="$1:$PATH"
        fi
    fi
}

# Setup

## Make directories for HLS and Dash (used in apache2 for the camera output)
mkdir -p /dev/shm/hls
if [ ! /var/www/html/hls ] ; then
  ln -s /dev/shm/hls /var/www/html/hls
fi
mkdir -p /dev/shm/dash

# Sys
alias sys="uname -a"
alias rconfig="sudo raspi-config"
alias update="sudo apt update"
alias upgrade="sudo apt full-upgrade"
alias upclean="sudo apt clean"
alias uprem="sudo apt autoremove"
alias listusb="lsusb"
alias listvideo="ls /dev/video*"
alias record="libcamera-vid -t 0 --width 1080 --height 720 --shutter 120 --framerate 30 -q 100 -n --inline --listen -o tcp://0.0.0.0:8888 -v"
alias recordd="libcamera-vid -t 0 --width 1080 --height 720 -q 100 -n --inline --listen -o tcp://0.0.0.0:8888 -v &"
alias play="ffplay tcp://0.0.0.0:8888 -vf \"setpts=N/30\" -fflags nobuffer -flags low_delay -framedrop"

alias driverinfo="v4l2-ctl -d /dev/video0 --all"
alias listdevices="v4l2-ctl --list-devices"
alias supportedformats="v4l2-ctl --list-formats"
alias listencoders="ffmpeg -hide_banner -encoders | grep -E \"h264|mjpeg\""
alias listallencoders="ffmpeg -encoders"
alias listsupportedformats="ffmpeg -h encoder=h264_omx"

alias listcodecs="ffmpeg -codecs"
alias listh264="ffmpeg -codecs | grep -E \"h264\""

alias restart="sudo reboot"

alias reload="source ~/.profile"

alias c="clear"

alias installneovim="sudo apt-get install neovim" # is an older version, use snap (see further down)
alias installcurl="sudo apt install curl"
alias vi="nvim"

# RVM
alias installrvm="\curl -sSL https://get.rvm.io | bash -s stable --ruby"

# list aliases
alias commands="grep -in --color -e '^alias\s+*' ~/.bash_aliases | sed 's/alias //' | grep --color -e ':[a-z][a-z0-9]*'"


alias installsnap="sudo apt install snapd"

alias installngrok="sudo snap install ngrok"

alias installnewerneovim="sudo snap install --classic nvim"
alias installnvchad="git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
nvim +'hi NormalFloat guibg=#1e222a' +PackerSync"

installNvchad () {
  if [ ! -d /snap/bin ] ; then
   installsnap
   echo "pathmunge \"/snap/bin\"" >> ~/.bash_aliases
  fi

  if [ ! -d /home/pi/.config/nvim ] ; then
   installnewerneovim
   installnvchad
   echo "alias vi=\"nvim\"" >> ~/.bash_aliases
  fi

  reload
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

# Writes to output.mp4 from the libcamera-vid stream (record alias)
fftest () {
  ffmpeg -y \
    -input_format h264 \
    -i tcp://0.0.0.0:8888 \
    -c: copy \
    output.mp4
}

# HLS output
ffhls () {
  ffmpeg -y \
    -i tcp://0.0.0.0:8888 \
    -c: copy \
    -f hls \
    -hls_time 1 \
    -hls_list_size 0 \
    /dev/shm/hls/live.m3u8
}
# -c:v copy \

# Dash output
ffdash () {
  ffmpeg \
    -i tcp://0.0.0.0:8888 \
    -c:v copy \
    -f dash \
    -seg_duration 1 \vcgencmd get_camera
    -streaming 1 \
    -window_size 30 -remove_at_exit 1 \
    /dev/shm/dash/live.mpd
}

writeToHlsFile () {
cat << EOF > $1
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Live Stream</title>
    </head>
    <body>
        <script src="https://cdn.jsdelivr.net/npm/hls.js@latest"></script>
        <video id="video" controls autoplay></video>
        <script>
            var video = document.getElementById("video");
            var videoSrc = "hls/live.m3u8";
            // First check for native browser HLS support
            if (video.canPlayType("application/vnd.apple.mpegurl")) {
                video.src = videoSrc;
            }
            // If no native HLS support, check if hls.js is supported
            else if (Hls.isSupported()) {
                var hls = new Hls();
                hls.loadSource(videoSrc);
                hls.attachMedia(video);
            }
        </script>
    </body>
</html>
EOF
}

setHlsFiles () {
  sudo chown pi:pi /var/www/html
  touch /var/www/html/hls.html
  chown pi:pi /var/www/html/hls.html
  writeToHlsFile /var/www/html/hls.html
}

writeToRecord () {
cat << EOF > $1
#!/bin/bash
shopt -s expand_aliases
source ~/.bash_aliases
recordd
EOF
}

writeToServe () {
cat << EOF > $1
#!/bin/bash
shopt -s expand_aliases
source ~/.bash_aliases
ffhls
EOF
}

setStartup () {
  sudo touch ~/Development/record.sh
  writeToRecord ~/Development/record.sh

  sudo touch ~/Development/serve.sh
  writeToServe ~/Development/serve.sh
}

postImageSetup () {
  update
  upgrade
 
  # Install ffmpeg
  sudo apt install -y ffmpeg

  # Install Apache
  sudo apt install -y apache2

  setHlsFiles
  setStartup

  # Install curl
  installcurl

  # Install RVM
  command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
  command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
  installrvm 

  # Install NvChad
  installNvchad

  # Install Nerd Fonts
  installNerdFonts
}
# sudo mv /var/www/html/hls.html /var/www/html/index.html <- maybe add to post setup, 

pathmunge /snap/bin
pathmunge ~/.rvm/bin

# De-dupe path and enforce order
if [ -n "$PATH" ]; then
  old_PATH=$PATH:; PATH=/home/pi/.rvm/gems/ruby-3.0.0/bin
  while [ -n "$old_PATH" ]; do
    x=${old_PATH%%:*}       # the first remaining entry
    case $PATH: in
      *:"$x":*) ;;          # already there
      *) PATH=$PATH:$x;;    # not there yet
    esac
    old_PATH=${old_PATH#*:}
  done
  PATH=${PATH#:}
  unset old_PATH x
fi

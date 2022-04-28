# pidotfiles
dotfiles just for raspberry pi

## Raspberry PI 4 Model B

sys: Linux pi 5.10.92-v7l+ #1514 SMP Mon Jan 17 17:38:03 GMT 2022 armv7l GNU/Linux

<!--
# This seems important: https://www.dacast.com/blog/how-to-connect-a-network-camera-to-a-rtmp-online-video-platform/
# Notes: 
#  - FFmpeg
#     - intro: https://www.dacast.com/blog/how-to-broadcast-live-stream-using-ffmpeg/
#     - https://ffmpeg.org/documentation.html
#     - https://ffmpeg.org/download.html#get-sources
#     - https://trac.ffmpeg.org/wiki/StreamingGuide
#     - https://ffmpeg.org/ffplay.html#Stream-specifiers-1
#     - https://www.codeinsideout.com/blog/pi/stream-ffmpeg-hls-dash/ <- was the closest/best resource so far for trying to et libcamera-vid -> stream over http
#  - mkvserver https://github.com/klaxa/mkvserver_mk2
#



. copy over .bash_aliases

---

. run installrvm

command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
command curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -

Required for insallrvm ^

---

. reload

. update

. upgrade

. setupNvchad <- nvim, command not found at the end...?

^ changed a lot here..... should wipe HD clean and restart

installNerdFonts

installed ffmpeg
sudo apt install -y ffmpeg

Installed apache:
sudo apt install -y apache2

Link hls folder:
sudo ln -hls /s/dev/shm /hls/var/www/html

Resources/Links: 
 - https://www.acunetix.com/blog/articles/10-tips-secure-apache-installation/
 - https://www.tecmint.com/apache-security-tips/
 - https://geekflare.com/10-best-practices-to-secure-and-harden-your-apache-web-server/
 - https://help.dreamhost.com/hc/en-us/articles/226327268-The-most-important-steps-to-take-to-make-an-Apache-server-more-secure
-->

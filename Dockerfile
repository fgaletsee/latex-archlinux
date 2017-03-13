FROM base/archlinux

# Add mirrors 
RUN printf ' \
Server = https://archlinux.surlyjake.com/archlinux/$repo/os/$arch \n\
Server = http://mirrors.evowise.com/archlinux/$repo/os/$arch \n\
Server = http://mirror.rackspace.com/archlinux/$repo/os/$arch \n\
Server = http://ftp.halifax.rwth-aachen.de/archlinux/$repo/os/$arch \n\
Server = https://mirror.f4st.host/archlinux/$repo/os/$arch \n\
Server = http://ftp.sh.cvut.cz/arch/$repo/os/$arch \n\
Server = http://ftp.nluug.nl/os/Linux/distr/archlinux/$repo/os/$arch \n\
' > /etc/pacman.d/mirrorlist

# Update package database
RUN pacman --noconfirm -Syu archlinux-keyring reflector rsync

# Rank mirrors 
RUN reflector --verbose -l 200 -f 50 --sort rate | tee /etc/pacman.d/mirrorlist

# Dependencies 
RUN pacman --noconfirm -S sed grep which diffutils gawk gettext gzip tar file git

# LaTex
RUN pacman --noconfirm -S texlive-most biber minted

# Redo Updating TeXLive filename database...
RUN /usr/share/libalpm/scripts/mktexlsr

# Redo Updating TeXLive font maps...
RUN /usr/share/libalpm/scripts/texlive-updmap

# Source perlbin to setup PATH in a non-interactive session
RUN printf '\
source /etc/profile.d/perlbin.sh\
' > /root/.bashrc

# Remove the cached packages
RUN paccache -rk0

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
RUN pacman --noconfirm -Syu archlinux-keyring grep sed

# Rank mirrors 
#RUN curl -o /etc/pacman.d/mirrorlist https://www.archlinux.org/mirrorlist/all/
#RUN grep -Pzo '(?s)\n\K## (Worldwide|United States|Germany)\n.*?##' /etc/pacman.d/mirrorlist | grep '## ' --after-context=5 --no-group-separator -a | cut -c2- > /etc/pacman.d/mirrorlist.backup
#RUN rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

# Dependencies 
RUN pacman --noconfirm -S sed which diffutils gawk gettext gzip tar file 

# LaTex
RUN pacman --noconfirm -S git texlive-core texlive-bibtexextra texlive-fontsextra texlive-latexextra biber minted

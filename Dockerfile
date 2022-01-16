FROM chendscm/archlinux-yay

# setup
USER root
COPY pacman.conf /opt/chendsystem/basic/pacman.conf
COPY git /opt/chendsystem/git/

# setup pacman to get a full image
RUN sed -i 's/NoExtract/#NoExtract/g' /etc/pacman.conf
RUN sed -i 's/HoldPkg/#HoldPkg/g' /etc/pacman.conf
RUN cat /opt/chendsystem/basic/pacman.conf >> /etc/pacman.conf

# setup keyring
RUN rm -rf /etc/pacman.d/gnupg
RUN pacman-key --init
RUN pacman-key --populate archlinux
RUN pacman -Sy --noconfirm archlinux-keyring archlinuxcn-keyring

# reinstall packages to restore all its files
RUN pacman -Sy --noconfirm pacman pacman-contrib
RUN pacman -Sy --noconfirm man-db man-pages
RUN pacman -Syu --noconfirm
RUN pacman -Sy --noconfirm base base-devel linux linux-firmware

RUN pacman -Qqn | pacman -S --noconfirm  -

# install packages
USER user
RUN yay -Sy --noconfirm chendsystem-basic

# ssh key
USER root
RUN mkdir /root/.ssh \
 && touch /root/.ssh/known_hosts \
 && ssh-keyscan github.com >> /root/.ssh/known_hosts
RUN --mount=type=secret,id=ssh_id,target=/root/.ssh/id_rsa
# compile
RUN cd /opt/chendsystem/git/ChezScheme/; ./configure; make install

# file
RUN mkdir /data \
 && chmod -R 777 /data
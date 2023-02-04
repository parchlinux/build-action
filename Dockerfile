FROM archlinux:latest

# Install & Update requarments. 
RUN pacman -Syu \
    archiso \
    base \
    base-devel \
    git \
    python \
    python-pip --noconfirm

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

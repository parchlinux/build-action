FROM archlinux:latest

# Install & Update requarments. 
RUN pacman -Syu \
    archiso \
    base \
    basedevel \
    git \
    python \
    python-pip --noconfirm

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

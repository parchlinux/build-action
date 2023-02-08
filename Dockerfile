FROM archlinux:latest

# Install & Update requarments. 
RUN pacman -Syu \
    archiso \
    base \
    base-devel \
    git \
    python \
    python-pip --noconfirm

# Install Python requarments.
RUN python -m pip install PyGithub

COPY release.py /release.py

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

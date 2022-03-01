FROM ubuntu:20.04

LABEL maintainer="NoskLo"

# Install tools required for the project
# Run 'docker build --no-cache .' to udpate dependencies
RUN dpkg --add-architecture armhf
RUN apt update && apt full-upgrade -y
RUN apt install -y tzdata && apt clean
RUN apt install -y \
    gcc-arm-linux-gnueabihf \
    git \
    make \
    cmake \
    python3 \
    curl \
    libsdl2-2.0-0 \
    nano \
    libc6:armhf \
    libncurses5:armhf \
    libstdc++6:armhf \
 && apt clean \
 && apt purge -y wget

# Install the box86 to emulate x86 platform (for steamcmd cliente)
WORKDIR /root
RUN git clone https://github.com/ptitSeb/box86 \
 && mkdir -p /root/box86/build \
 && cd /root/box86/build \
 && cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo \
 && make -j4 \
 && make install \
 && cd /root \
 && rm -rf /root/box86

# Install steamcmd and download the valheim server:
WORKDIR /root/steam
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
# RUN export DEBUGGER="/usr/local/bin/box86"
ENV BOX86_DYNAREC "0"
ENV DEBUGGER "/usr/local/bin/box86"
RUN ./steamcmd.sh +@sSteamCmdForcePlatformType linux +login anonymous +force_install_dir /root/valheim_server +app_update 896660 validate +quit

## Box64 installation
WORKDIR /root
RUN git clone https://github.com/ptitSeb/box64 \
 && mkdir -p /root/box64/build \
 && cd /root/box64/build \
 && cmake .. -DRPI4ARM64=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo \
 && make -j4 \
 && make install \
 && cd /root \
 && rm -rf /root/box64

# Specific for run Valheim server
EXPOSE 2456-2457/udp
WORKDIR /root
COPY bootstrap .
ENTRYPOINT ["/bin/bash", "/root/bootstrap"]

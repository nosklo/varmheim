# Varmheim
#### Valheim in Arm!

Experimental Docker file to run a Valheim server in aarch64

It was tested on ubuntu 20.04 aarch64 running in Oracle Cloud Always Free Tier

valheim.Dockerfile is based on the stardard repositories of box86 and box64.

## Compiled image:
You can find in the docker hub the image to run directly: https://hub.docker.com/repository/docker/nosklo/varmheim

## Requeriments:
Install oracle cloud always free tier VM.Standard.A1.Flex instance
Install docker and docker-composer

run it:

    $ docker-compose up -d --no-build

you can use environment variables to change the defaults:

PUBLIC=0               # 0 private / 1 public
PORT=2456              # The port that you want valheim server to listen 
NAME="Docker Valheim"  # Your amazing name of your server.
WORLD=Docker           # Your unique name of your world.
SAVEDIR=/vhsave        # Where to save your data.
PASSWORD=nopassword


## Thanks to those projects for making it possible:
- [box86](https://github.com/ptitSeb/box86)
- [box64](https://github.com/ptitSeb/box64)
- [docker](docker.com)

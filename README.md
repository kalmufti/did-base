# Desktop in Docker - Base Image

Desktop in Docker base image provide a Linux Xfce4 desktop environment by utilizing novnc plus all the necessary packages to build more interesting images.

## Usage

Basic command:

```docker
docker run --rm -it -p 6901:6901 kalmufti/did-base
```

Add container name, change host ip address and increase ram:

```docker
docker run --rm -it -p 6901:6901 --name novnc -e HOST_ADDR=192.168.1.1 --shm-size=2gb kalmufti/did-base
```

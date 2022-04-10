## podman for gokrazy

This package contains https://github.com/mgoltzsche/podman-static, a static
build of podman.

### Usage

Add `github.com/gokrazy/iptables`, `github.com/gokrazy/nsenter` and
`github.com/gokrazy/podman` to your `gokr-packer` command.

Login to your gokrazy device using
[breakglass](https://github.com/gokrazy/breakglass).

#### Option 1: store containers in RAM

If you only want to try something out without keeping the containers around
across reboots, it is faster to work in RAM:

```
mount -t tmpfs tmpfs /var
```

#### Option 2: store containers on disk

If your container data should be saved to disk, bind-mount a directory from your
permanent partition onto `/var`:

```
mkdir /perm/container-storage
mount --bind /perm/container-storage /var
```

#### Run a container

To have `podman` easily be able to find other binaries like `nsenter` and `iptables` simply add `/user` and `/usr/local/bin` to `PATH` before running `podman`.

```
export PATH=$PATH:/user:/usr/local/bin
podman run --rm -ti debian:sid
```

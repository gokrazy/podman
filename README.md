## podman for gokrazy

This package contains https://github.com/mgoltzsche/podman-static, a static
build of podman.

### Usage

Add the following packages to your `gokr-packer` command:

```
github.com/gokrazy/iptables \
github.com/gokrazy/nsenter \
github.com/gokrazy/podman \
github.com/greenpau/cni-plugins/cmd/cni-nftables-portmap \
github.com/greenpau/cni-plugins/cmd/cni-nftables-firewall
```

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

```
podman run --rm -ti docker.io/library/debian:sid
```

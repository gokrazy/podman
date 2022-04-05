## podman for gokrazy

This package contains https://github.com/mgoltzsche/podman-static, a static
build of podman.

### Usage

Add `github.com/gokrazy/iptables` and `github.com/gokrazy/podman` to your
`gokr-packer` command.

Login to your gokrazy device using
[breakglass](https://github.com/gokrazy/breakglass) and run:

```
mount -t tmpfs tmpfs /var
mount -t cgroup2 cgroup2 /sys/fs/cgroup/

touch nsenter
chmod +x nsenter

podman run --rm -ti debian:sid
```

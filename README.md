## podman for gokrazy

This package contains https://github.com/mgoltzsche/podman-static, a static
build of podman.

### Usage

Please see [gokrazy → Available packages → Docker
containers](https://gokrazy.org/packages/docker-containers/) for instructions on
how to use this repository.

The sections below assume you are logged into to your gokrazy device using
[breakglass](https://github.com/gokrazy/breakglass).


#### Run a container

```
podman run --rm -ti docker.io/library/debian:sid
```

#### Optional: tmpfs

By default, containers are stored on disk (`/var` is a symlink to `/perm/var` on
the permanent data partition). If you only want to try something out without
keeping the containers around across reboots, it is faster to work in RAM:

```
mount -t tmpfs tmpfs /var
```

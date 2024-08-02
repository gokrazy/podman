all: _gokrazy/extrafiles_arm64.tar _gokrazy/extrafiles_amd64.tar

_gokrazy/extrafiles_amd64.tar:
	mkdir -p _gokrazy/extrafiles_amd64
	curl -fsSL https://github.com/mgoltzsche/podman-static/releases/download/v4.9.5/podman-linux-amd64.tar.gz | \
		tar xzv --strip-components=1 -C _gokrazy/extrafiles_amd64/ --exclude README.md
	cd _gokrazy/extrafiles_amd64 && \
		wget https://raw.githubusercontent.com/greenpau/cni-plugins/main/assets/net.d/87-podman-bridge.conflist -O etc/cni/net.d/87-podman-bridge.conflist && \
		ln -s /user/cni-nftables-firewall usr/local/lib/cni/cni-nftables-firewall && \
		ln -s /user/cni-nftables-portmap usr/local/lib/cni/cni-nftables-portmap && \
		tar cf ../extrafiles_amd64.tar *
	rm -rf _gokrazy/extrafiles_amd64

_gokrazy/extrafiles_arm64.tar:
	mkdir -p _gokrazy/extrafiles_arm64
	curl -fsSL https://github.com/mgoltzsche/podman-static/releases/download/v4.9.5/podman-linux-arm64.tar.gz | \
		tar xzv --strip-components=1 -C _gokrazy/extrafiles_arm64/ --exclude README.md
	cd _gokrazy/extrafiles_arm64 && \
		wget https://raw.githubusercontent.com/greenpau/cni-plugins/main/assets/net.d/87-podman-bridge.conflist -O etc/cni/net.d/87-podman-bridge.conflist && \
		ln -s /user/cni-nftables-firewall usr/local/lib/cni/cni-nftables-firewall && \
		ln -s /user/cni-nftables-portmap usr/local/lib/cni/cni-nftables-portmap && \
		tar cf ../extrafiles_arm64.tar *
	rm -rf _gokrazy/extrafiles_arm64

clean:
	rm -f _gokrazy/extrafiles_*.tar

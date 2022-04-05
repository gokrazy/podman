_gokrazy/extrafiles.tar:
	mkdir -p _gokrazy/extrafiles
	curl -fsSL https://github.com/mgoltzsche/podman-static/releases/latest/download/podman-linux-arm64.tar.gz | \
		tar xzv --strip-components=1 -C _gokrazy/extrafiles/ --exclude README.md
	cd _gokrazy/extrafiles && tar cf ../extrafiles.tar *
	rm -rf _gokrazy/extrafiles

clean:
	rm -f _gokrazy/extrafiles.tar

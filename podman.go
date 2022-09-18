// Binary podman is a gokrazy wrapper program that runs the bundled podman
// executable in /usr/local/bin/podman after doing any necessary runtime system
// setup.
package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strings"
	"syscall"
)

func isMounted(mountpoint string) (bool, error) {
	b, err := ioutil.ReadFile("/proc/self/mountinfo")
	if err != nil {
		if os.IsNotExist(err) {
			return false, nil // platform does not have /proc/self/mountinfo, fall back to not verifying
		}
		return false, err
	}

	for _, line := range strings.Split(strings.TrimSpace(string(b)), "\n") {
		parts := strings.Fields(line)
		if len(parts) < 5 {
			continue
		}
		if parts[4] == mountpoint {
			return true, nil
		}
	}

	return false, nil
}

func makeWritable(dir string) error {
	mounted, err := isMounted(dir)
	if err != nil {
		return err
	}
	if mounted {
		// Nothing to do, directory is already mounted.
		return nil
	}

	// Read all regular files in this directory.
	regularFiles := make(map[string]string)
	fis, err := os.ReadDir(dir)
	if err != nil {
		return err
	}
	for _, fi := range fis {
		b, err := os.ReadFile(filepath.Join(dir, fi.Name()))
		if err != nil {
			return err
		}
		regularFiles[fi.Name()] = string(b)
	}

	if err := syscall.Mount("tmpfs", dir, "tmpfs", 0, ""); err != nil {
		return fmt.Errorf("tmpfs on %s: %v", dir, err)
	}

	// Write all regular files from memory back to new tmpfs.
	for name, contents := range regularFiles {
		if err := os.WriteFile(filepath.Join(dir, name), []byte(contents), 0644); err != nil {
			return err
		}
	}

	return nil
}

func main() {
	// Workaround for podman ≤ v4.2.1, which failed on read-only /etc:
	// https://github.com/containers/common/commit/50c2c97c3b828f908f1a22f6967c1136163dcefd
	//
	// The fix was imported into podman as part of commit
	// https://github.com/containers/podman/commit/0f739355635d5bc4d538cf88009d7af533e7c289
	//
	// TODO: drop this entire binary with podman > v4.2.1
	if err := makeWritable("/etc/cni/net.d/"); err != nil {
		log.Fatal(err)
	}

	if err := syscall.Exec("/usr/local/bin/podman", os.Args, os.Environ()); err != nil {
		log.Fatal(err)
	}
}

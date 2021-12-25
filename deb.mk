$(BUILD)/debian/deb/Packages: | $(BUILD)/debian/deb/
	curl http://http.us.debian.org/debian/dists/sid/main/binary-arm64/Packages.xz | xzcat > $@
	curl http://http.us.debian.org/debian/dists/sid/main/binary-all/Packages.xz | xzcat >> $@

$(BUILD)/debian/deb/%.deb: $(BUILD)/debian/deb/Packages deb.pl | $(BUILD)/debian/deb/
	curl http://http.us.debian.org/debian/$(shell perl deb.pl "$*" < $<) > $@

$(BUILD)/qemu-kernel: $(BUILD)/debian/deb/linux-image-5.15.0-2-cloud-arm64-unsigned.deb
	$(MKDIR) $(BUILD)/kernel
	dpkg --extract $< $(BUILD)/kernel
	cp $(BUILD)/kernel/boot/vmlinuz* $@

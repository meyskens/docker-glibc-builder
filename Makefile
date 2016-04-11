TARGET ?= amd64
ARCHS ?= amd64 armhf i368
BASE_ARCH ?= amd64


build: tmp-$(TARGET)/Dockerfile
	docker build --build-arg ARCH=$(TARGET) --no-cache -t meyskens/glibc-builder:$(TARGET)-latest tmp-$(TARGET)
	docker run --rm meyskens/multiarch-nodejs:$(TARGET)-latest uname -a


tmp-$(TARGET)/Dockerfile: Dockerfile $(shell find overlay-common overlay-$(TARGET))
	rm -rf tmp-$(TARGET)
	mkdir tmp-$(TARGET)
	cp Dockerfile $@
	cp -rf overlay-common tmp-$(TARGET)/
	cp -rf overlay-$(TARGET) tmp-$(TARGET)/
	for arch in $(ARCHS); do                     \
	  if [ "$$arch" != "$(TARGET)" ]; then       \
	    sed -i "/arch=$$arch/d" $@;              \
	  fi;                                        \
	done
	sed -i '/#[[:space:]]*arch=$(TARGET)/s/^#//' $@
	sed -i 's/#[[:space:]]*arch=$(TARGET)//g' $@
	cat $@
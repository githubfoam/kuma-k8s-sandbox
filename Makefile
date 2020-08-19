IMAGE := alpine/fio
APP:="app/deploy-openesb.sh"

deploy-centos:
	bash scripts/deploy-centos.sh

deploy-debian:
	bash scripts/deploy-debian.sh

deploy-ubuntu:
	bash scripts/deploy-ubuntu.sh

deploy-libvirt:
	bash scripts/deploy-libvirt.sh

deploy-vagrant:
	bash scripts/deploy-vagrant.sh

push-image:
	docker push $(IMAGE)
.PHONY: deploy-vagrant deploy-libvirt deploy-boxes push-image

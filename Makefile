IMAGE := alpine/fio
APP:="app/deploy-openesb.sh"

deploy-debian:
	bash scripts/deploy-debian.sh

deploy-boxes:
	bash scripts/deploy-boxes.sh

deploy-libvirt:
	bash scripts/deploy-libvirt.sh

deploy-vagrant:
	bash scripts/deploy-vagrant.sh

push-image:
	docker push $(IMAGE)
.PHONY: deploy-vagrant deploy-libvirt deploy-boxes push-image

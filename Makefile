IMAGE := alpine/fio
APP:="app/deploy-openesb.sh"

deploy-kong-kuma:
	bash app/deploy-kong-kuma.sh

deploy-minikube-latest:
	bash app/deploy-minikube_latest.sh

deploy-minikube:
	bash app/deploy-minikube.sh

push-image:
	docker push $(IMAGE)
.PHONY: deploy-openesb deploy-dashboard push-image

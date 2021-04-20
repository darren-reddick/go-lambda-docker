.dockerimage-%: Dockerfile
	docker build -t aws:deploy .
	touch .dockerimage-$*

.PHONY: tf-init-%
tf-init-%: .dockerimage-%
	cd $* && docker run -w /infra -e AWS_PROFILE=${AWS_PROFILE} \
		-v ${PWD}/$*:/infra \
		-v ~/.aws/credentials:/root/.aws/credentials \
		aws:deploy init

.PHONY: tf-plan-%
tf-plan-%: .dockerimage-% tf-init-%
	docker run -w /infra -e AWS_PROFILE=${AWS_PROFILE} \
		-v ${PWD}/$*:/infra \
		-v ~/.aws/credentials:/root/.aws/credentials \
		aws:deploy plan -out aws.tfplan

.PHONY: tf-apply-%
tf-apply-%: .dockerimage-% tf-init-%
	docker run -w /infra -e AWS_PROFILE=${AWS_PROFILE} \
		-v ${PWD}/$*:/infra \
		-v ~/.aws/credentials:/root/.aws/credentials \
		aws:deploy apply aws.tfplan

.PHONY: tf-destroy-%
tf-destroy-%: .dockerimage-%
	docker run -w /infra -e AWS_PROFILE=${AWS_PROFILE} \
		-v ${PWD}/$*:/infra \
		-v ~/.aws/credentials:/root/.aws/credentials \
		aws:deploy destroy -auto-approve
.DEFAULT_GOAL := help

REMOTE_USER=basil
IMAGE_BASE_ANSIBLE=cytopia/ansible:2.13
IMAGE_LOCAL_ANSIBLE=basil/ansible
DOCKER_BUILD_ANSIBLE=docker build --build-arg IMAGE_BASE_ANSIBLE=$(IMAGE_BASE_ANSIBLE) --tag $(IMAGE_LOCAL_ANSIBLE) -f $(PWD)/infrastructure/ansible/Dockerfile $(PWD)/infrastructure/ansible
DOCKER_RUN_ANSIBLE=docker run --rm -it -v $(PWD)/infrastructure/ansible:/data -v $(PWD)/infrastructure/ansible_galaxy:/root/.ansible $(IMAGE_LOCAL_ANSIBLE)
RUN_ANSIBLE=$(DOCKER_BUILD_ANSIBLE) && $(DOCKER_RUN_ANSIBLE)
RUN_ANSIBLE_PLAYBOOK=$(RUN_ANSIBLE) ansible-playbook
RUN_ANSIBLE_GALAXY=$(RUN_ANSIBLE) ansible-galaxy

.PHONY: help
help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9\./_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

.PHONY: ansible-galaxy-install
ansible-galaxy-install: ## Install ansible roles and collections
	@$(RUN_ANSIBLE_GALAXY) install -r requirements.yml

.PHONY: ansible-playbook-run
ansible-playbook-run: ## Install everything on Raspberry Pi
	@$(RUN_ANSIBLE_PLAYBOOK) -i inventory.yml --ask-pass --user $(REMOTE_USER) raspberry_pi.yml

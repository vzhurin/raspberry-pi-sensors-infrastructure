.DEFAULT_GOAL := help
.PHONY: $(filter-out todo,$(MAKECMDGOALS))

IMAGE_ANSIBLE=cytopia/ansible:2.13
RUN_ANSIBLE=docker run --rm -it -v $(PWD)/infrastructure/ansible:/data -v $(PWD)/infrastructure/ansible_galaxy:/root/.ansible $(IMAGE_ANSIBLE)
RUN_ANSIBLE_PLAYBOOK=$(RUN_ANSIBLE) ansible-playbook
RUN_ANSIBLE_GALAXY=$(RUN_ANSIBLE) ansible-galaxy

help: ## Outputs this help screen
	@grep -E '(^[a-zA-Z0-9\./_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

ansible-galaxy-install:
	@$(RUN_ANSIBLE_GALAXY) install -r requirements.yml
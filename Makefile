.PHONY: all setup python ansible

# Default target
all: setup

# Composite setup task
setup: python ansible
	@echo "✅ All setup tasks completed."

# Install Python packages
python:
	@echo "📦 Installing Python packages..."
	@if [ -f requirements.txt ]; then \
		pip install --upgrade pip && \
		pip install -r requirements.txt ; \
	else \
		echo "⚠️  No requirements.txt found."; \
	fi

# Install Ansible collections
ansible:
	@echo "📚 Installing Ansible collections..."
	@if [ -f collections.yml ]; then \
		ansible-galaxy collection install -r collections.yml ; \
	else \
		echo "⚠️  No collections.yml found."; \
	fi

deploy_clab:
	containerlab deploy -t clab_topologies/l2ls.clab.yaml

redeploy_clab:
	containerlab deploy -t clab_topologies/l2ls.clab.yaml --reconfigure

destroy_clab:
	containerlab destroy -t clab_topologies/l2ls.clab.yaml

build_avd: # Generate intended cfgs and docs
	ansible-playbook build.yml

deploy_avd_dryrun: # Do the build steps then execute a dry run intended config deployment to all nodes
	ansible-playbook deploy.yml --check --diff

deploy_avd: # Do the build steps then deploy intended configs to all nodes
	ansible-playbook deploy.yml --diff
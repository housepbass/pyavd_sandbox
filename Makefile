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

deploy_clab: # Deploy clab nodes
	sudo containerlab deploy -t clab_topologies/l2ls.clab.yaml

redeploy_clab: # Re-deploy clab nodes from scratch
	sudo containerlab deploy -t clab_topologies/l2ls.clab.yaml --reconfigure

destroy_clab: # Destroy/cleanup clab nodes
	sudo containerlab destroy -t clab_topologies/l2ls.clab.yaml

build_avd: # Generate intended cfgs and docs
	ansible-playbook ./l2ls-fabric/build.yml -i ./l2ls-fabric/inventory.yml

deploy_avd: # Do the build steps and deploy intended configs to all nodes. Must run twice due to mgmt VRF changes.
	ansible-playbook ./l2ls-fabric/deploy.yml -i ./l2ls-fabric/inventory.yml

install_avd_examples: # Install examples from https://avd.arista.com/5.7/index.html
	ansible-playbook arista.avd.install_examples
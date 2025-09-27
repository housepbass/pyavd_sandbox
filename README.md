## AVD Sandbox

### Description

This environment provides a quick and dirty way to get started using Arista's ansible.avd collection with containerized Arista eos devices.

### Quick Start

1. [Install the Dev Containers Extension](https://code.visualstudio.com/docs/devcontainers/tutorial) into your vscode IDE
2. Clone this repo into your machine
3. Build and open the Dev Container with vscode
4. Run `make deploy_clab` do deploy the eos containers via [Containerlab](https://containerlab.dev/manual/kinds/ceos/)
5. Run `make deploy_avd` to execute the `deploy.yml` ansible playbook. **You might have to run this twice due to initial management VRF configuration changes.**

After running through these steps, you'll have a fully configured layer 2 leaf-spine fabric with 2 spines and 3 leafs. The spines are running MLAG, 2 leafs are running MLAG, and there's 1 standalone leaf. All leafs have port-channels uplinks to the spines. 

All fabric options are fully configurable via group_vars groups. If you're changing cable connections between nodes, make sure to first destroy the lab with `make destroy_clab`, reconfigure the cables in the containerlab topology file, then redeploy the lab with `make redeploy_clab`.

I'd like to do more nodes but my poor macbook couldn't keep up past 5.

Extending this environment should be straightforward; use the [pyavd docs](https://avd.arista.com/4.5/examples/l2ls-fabric/index.html) as a reference.

Lastly, Arista's example designs can be installed using `make install_avd_examples`. To leverage them in this sandbox, study the example docs and modify the inventory files and containerlab topologies as needed. 

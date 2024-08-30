# AZRS resources
set --export AZ_AZRS_SUB "7d07dbdd-8117-46e9-8f58-721da3f32fd4"
set --export AZ_AZRS_RG "pratyush-a100-us"
set --export AZ_AZRS_BASTION "vnet-bastion"
set --export AZ_AZRS_VM_IP1 "10.0.0.6"
set --export AZ_AZRS_VM_IP2 "10.0.0.8"

# CloudBank resources
set --export AZ_CB_SUB "4d2d85cc-432b-4e0f-8bee-b4d7dd6a6d47"
set --export AZ_CB_RG "roy-alchemists-uswest"
set --export AZ_CB_BASTION "roy-alchemists-a100-vm-bastion"
set --export AZ_CB_VM_IP "10.0.0.4"

alias sub-cb "az account set --subscription $AZ_CB_SUB"
alias sub-azrs "az account set --subscription $AZ_AZRS_SUB"
alias az-login "az login --scope https://management.core.windows.net//.default"

function vm1  
	az account set --subscription $AZ_AZRS_SUB
	az network bastion ssh \
		-n $AZ_AZRS_BASTION \
		-g $AZ_AZRS_RG \
		--target-ip-address $AZ_AZRS_VM_IP1 \
		--auth-type ssh-key \
		--user azureuser \
		--ssh-key ~/.ssh/yuhan_id_rsa
end

function vm2  
	az account set --subscription $AZ_CB_SUB
	az network bastion ssh \
		-n $AZ_CB_BASTION \
		-g $AZ_CB_RG \
		--target-ip-address $AZ_CB_VM_IP \
		--auth-type ssh-key \
		--user azureuser \
		--ssh-key ~/.ssh/yuhan_id_rsa
end

function vm3
	az account set --subscription $AZ_AZRS_SUB
	az network bastion ssh \
		-n $AZ_AZRS_BASTION \
		-g $AZ_AZRS_RG \
		--target-ip-address $AZ_AZRS_VM_IP2 \
		--auth-type ssh-key \
		--user azureuser \
		--ssh-key ~/.ssh/yuhan_id_rsa
end

function vm4
	az account set --subscription $AZ_AZRS_SUB
	az network bastion ssh \
		-n $AZ_AZRS_BASTION \
		-g "inigog-a100-southcentralus" \
		--target-ip-address "10.0.0.5" \
		--auth-type ssh-key \
		--user azureuser \
		--ssh-key ~/.ssh/yuhan_id_rsa
end

function vm5
	az account set --subscription $AZ_AZRS_SUB
	az network bastion ssh \
		-n $AZ_AZRS_BASTION \
		-g "inigog-a100-southcentralus" \
		--target-ip-address "10.0.0.4" \
		--auth-type ssh-key \
		--user azureuser \
		--ssh-key ~/.ssh/yuhan_id_rsa
end

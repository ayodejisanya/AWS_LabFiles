AZURE VM TEMPLATE

CREATE VM PASSWORD
CREATE VM VIRTUAL MACHINE
CREATE VM SECURITY GROUP
CREATE VM VITUAL PRIVATE NETWORK
CREATE VM NETWORK INTERFACE CARD
CREATE VM PUBLIC IP
CREATE VM STORAGE ACCOUNT DIGNOSITIC
CREATE VM STORAGE ACCOUNT DISK

{
    "$schema": "https://schema.management.azure.com/schemas/2020-05-05/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "virtualMachines_SimpleVM_adminPassword": {
            "defaultValue": null,
            "type": "SecureString"
        },
        "virtualMachines_GamarVM_name": {
            "defaultValue": "GamarVM",
            "type": "String"
        },
        "networkInterfaces_gamarvm565_name": {
            "defaultValue": "gamarvm565",
            "type": "String"
        },
        "networkSecurityGroups_GamarVM_nsg_name": {
            "defaultValue": "GamarVM-nsg",
            "type": "String"
        },
        "publicIPAddresses_GamarVM_ip_name": {
            "defaultValue": "GamarVM-ip",
            "type": "String"
        },
        "virtualNetworks_GamarNetwork_name": {
            "defaultValue": "GamarNetwork",
            "type": "String"
        },
        "storageAccounts_gamarvmdiag283_name": {
            "defaultValue": "gamarvmdiag283",
            "type": "String"
        },
        "storageAccounts_gamarvmdisks607_name": {
            "defaultValue": "gamarvmdisks607",
            "type": "String"
        }
    },
    "variables": {},
    "resources": [
        {
            "comments": "Generalized from resource: '/subscriptions/{SubscriptionID}/resourceGroups/GamarVM/providers/Microsoft.Compute/virtualMachines/GamarVM'.",
            "type": "Microsoft.Compute/virtualMachines",
            "name": "[parameters('virtualMachines_GamarVM_name')]",
            "apiVersion": "2015-06-15",
            "location": "CanadaCentral",
            "properties": {
                "hardwareProfile": {
                    "vmSize": "Standard_A1"
                },
                "storageProfile": {
                    "imageReference": {
                        "publisher": "MicrosoftWindowsServer",
                        "offer": "WindowsServer",
                        "sku": "2012-R2-Datacenter",
                        "version": "latest"
                    },
                    "osDisk": {
                        "name": "[parameters('virtualMachines_GamarVM_name')]",
                        "createOption": "FromImage",
                        "vhd": {
                            "uri": "[concat('https', '://', parameters('storageAccounts_gamarvmdisks607_name'), '.blob.core.windows.net', concat('/vhds/', parameters('virtualMachines_GamarVM_name'),'20170227073242.vhd'))]"
                        },
                        "caching": "ReadWrite"
                    },
                    "dataDisks": []
                },
                "osProfile": {
                    "computerName": "[parameters('virtualMachines_GamarVM_name')]",
                    "adminUsername": "ayodejisanya",
                    "windowsConfiguration": {
                        "provisionVMAgent": true,
                        "enableAutomaticUpdates": true
                    },
                    "secrets": [],
                    "adminPassword": "[parameters('virtualMachines_GamarVM_adminPassword')]"
                },
                "networkProfile": {
                    "networkInterfaces": [
                        {
                            "id": "[resourceId('Microsoft.Network/networkInterfaces', parameters('networkInterfaces_gamarvm565_name'))]"
                        }
                    ]
                }
            },
            "resources": [],
            "dependsOn": [
                "[resourceId('Microsoft.Storage/storageAccounts', parameters('storageAccounts_gamarvmdisks607_name'))]",
                "[resourceId('Microsoft.Network/networkInterfaces', parameters('networkInterfaces_gamarvm565_name'))]"
            ]
        },
        {
            "comments": "Generalized from resource: '/subscriptions/{SubscriptionID}/resourceGroups/GamarVM/providers/Microsoft.Network/networkInterfaces/gamarvm565'.",
            "type": "Microsoft.Network/networkInterfaces",
            "name": "[parameters('networkInterfaces_gamarvm565_name')]",
            "apiVersion": "2016-03-30",
            "location": "canadacentral",
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "ipconfig1",
                        "properties": {
                            "privateIPAddress": "10.0.0.4",
                            "privateIPAllocationMethod": "Dynamic",
                            "publicIPAddress": {
                                "id": "[resourceId('Microsoft.Network/publicIPAddresses', parameters('publicIPAddresses_GamarVM_ip_name'))]"
                            },
                            "subnet": {
                                "id": "[concat(resourceId('Microsoft.Network/virtualNetworks', parameters('virtualNetworks_GamarNetwork_name')), '/subnets/default')]"
                            }
                        }
                    }
                ],
                "dnsSettings": {
                    "dnsServers": []
                },
                "enableIPForwarding": false,
                "networkSecurityGroup": {
                    "id": "[resourceId('Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroups_GamarVM_nsg_name'))]"
                }
            },
            "resources": [],
            "dependsOn": [
                "[resourceId('Microsoft.Network/publicIPAddresses', parameters('publicIPAddresses_GamarVM_ip_name'))]",
                "[resourceId('Microsoft.Network/virtualNetworks', parameters('virtualNetworks_GamarNetwork_name'))]",
                "[resourceId('Microsoft.Network/networkSecurityGroups', parameters('networkSecurityGroups_GamarVM_nsg_name'))]"
            ]
        },
        {
            "comments": "Generalized from resource: '/subscriptions/{SubscriptionID}/resourceGroups/GamarVM/providers/Microsoft.Network/networkSecurityGroups/GamarVM-nsg'.",
            "type": "Microsoft.Network/networkSecurityGroups",
            "name": "[parameters('networkSecurityGroups_GamarVM_nsg_name')]",
            "apiVersion": "2016-03-30",
            "location": "canadacentral",
            "properties": {
                "securityRules": [
                    {
                        "name": "default-allow-rdp",
                        "properties": {
                            "protocol": "TCP",
                            "sourcePortRange": "*",
                            "destinationPortRange": "3389",
                            "sourceAddressPrefix": "*",
                            "destinationAddressPrefix": "*",
                            "access": "Allow",
                            "priority": 1000,
                            "direction": "Inbound"
                        }
                    }
                ]
            },
            "resources": [],
            "dependsOn": []
        },
        {
            "comments": "Generalized from resource: '/subscriptions/{SubscriptionID}/resourceGroups/GamarVM/providers/Microsoft.Network/publicIPAddresses/GamarVM-ip'.",
            "type": "Microsoft.Network/publicIPAddresses",
            "name": "[parameters('publicIPAddresses_GamarVM_ip_name')]",
            "apiVersion": "2016-03-30",
            "location": "canadacentral",
            "properties": {
                "publicIPAllocationMethod": "Dynamic",
                "idleTimeoutInMinutes": 4
            },
            "resources": [],
            "dependsOn": []
        },
        {
            "comments": "Generalized from resource: '/subscriptions/{SubscriptionID}/resourceGroups/GamarVM/providers/Microsoft.Network/virtualNetworks/GamarNetwork'.",
            "type": "Microsoft.Network/virtualNetworks",
            "name": "[parameters('virtualNetworks_GamarNetwork_name')]",
            "apiVersion": "2016-03-30",
            "location": "canadacentral",
            "properties": {
                "addressSpace": {
                    "addressPrefixes": [
                        "10.0.0.0/24"
                    ]
                },
                "subnets": [
                    {
                        "name": "default",
                        "properties": {
                            "addressPrefix": "10.0.0.0/24"
                        }
                    }
                ]
            },
            "resources": [],
            "dependsOn": []
        },
        {
            "comments": "Generalized from resource: '/subscriptions/{SubscriptionID}/resourceGroups/gamarvm/providers/Microsoft.Storage/storageAccounts/gamarvmdiag283'.",
            "type": "Microsoft.Storage/storageAccounts",
            "sku": {
                "name": "Standard_LRS",
                "tier": "Standard"
            },
            "kind": "Storage",
            "name": "[parameters('storageAccounts_gamarvmdiag283_name')]",
            "apiVersion": "2016-01-01",
            "location": "canadacentral",
            "tags": {},
            "properties": {},
            "resources": [],
            "dependsOn": []
        },
        {
            "comments": "Generalized from resource: '/subscriptions/{SubscriptionID}/resourceGroups/gamarvm/providers/Microsoft.Storage/storageAccounts/gamarvmdisks607'.",
            "type": "Microsoft.Storage/storageAccounts",
            "sku": {
                "name": "Standard_LRS",
                "tier": "Standard"
            },
            "kind": "Storage",
            "name": "[parameters('storageAccounts_gamarvmdisks607_name')]",
            "apiVersion": "2016-01-01",
            "location": "canadacentral",
            "tags": {},
            "properties": {},
            "resources": [],
            "dependsOn": []
        }
    ]
}
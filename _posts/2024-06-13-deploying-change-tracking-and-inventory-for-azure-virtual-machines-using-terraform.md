---
layout: post
title: "Deploying Change Tracking and Inventory for Azure Virtual Machines using Terraform"
tags: [ azure, terraform, virtual-machines ]
---

[Change Tracking and Inventory](https://learn.microsoft.com/en-us/azure/automation/change-tracking/overview-monitoring-agent) (CT) is an Azure service that allows you to track changes on both Windows and Linux virtual machines such as changes in software, files, registry, services/daemons. CT collects these changes in a log analytics workspace, allowing alerting rules to be set up on these changes. For example, you might want to be alerted when software is installed, the contents of a file or registry key changes or when a service stops running.

This article will teach you how to deploy CT using Terraform, since the documentation for this feature is less than ideal. The scope of this article is limited to deploying CT on Azure hosted virtual machines using the Azure Monitor Agent (AMA) as the current Log Analytics Agent based deployment will retire on the 31st of August 2024. I will offer two different kind of deployments: manually or using Azure Policy.

## Prerequisites

- An Azure hosted virtual machine with an installed AMA
- A log analytics workspace

## Manual Deployment

To create the manual deployment, I deployed CT using the Azure portal, downloaded the ARM template deployment and translated it to Terraform resources. The documentation and the documentation are pretty untransparent, but the deployment is pretty simple in essence. The manual deployment does a few things:

1. It deploys the ChangeTracking-Windows or ChangeTracking-Linux virtual machine extension;
2. It deploys the ChangeTracking log analytics solution to the log analytics workspace;
3. It deploys a CT data collection rule;
4. It assigns the data collection rule to the virtual machine.

<script src="https://gist.github.com/iTiamo/6b2202b96340fd63fd492668f6822d18.js"></script>

Within a few minutes of the deployment finishing, you should start to see logs flowing into your log analytics workspace. These will be in the ConfigurationData and ConfigurationChange tables. Additionally, in the change and inventory center you will see a graphical representation of the inventory of the virtual machine and the changes happening in the virtual machine.

![Querying raw log data of the onboarded virtual machine](/assets/images/querying_change_tracking.png)
*Querying raw log data of the onboarded virtual machine*


![The inventory of Linux daemons of the onboarded virtual machine](/assets/images/change_inventory_center.png)
*The inventory of Linux daemons of the onboarded virtual machine*

## Policy Based Deployment

A policy based deployment is possible too. Policies can be assigned at the resource group, subscription or management group scope and therefore are best fit to deploy CT at scale. The policies that are deployed by the policy initiative have the DeployIfNotExists effect, which means that they will run automatically if an affected resource is created or updated *after* the policy has been deployed. Resources created before the policy is deployed will not be updated. These can be remediated by creating a remediation task.

The policy specifications were retrieved using Azure CLI: `az policy set-definition list --query "[?displayName=='[Preview]: Enable ChangeTracking and Inventory for virtual machines']"`.

The example below will have the policy initiative deploy a system assigned managed identity. To remediate the resources that are not compliant this managed identity will need to be given additional rights required by the policy initiative. An alternative is to use a user assigned managed identity and assign the rights in Terraform. This is out of scope for this article.

<script src="https://gist.github.com/iTiamo/c71aea464676bb18630b47a1fafab686.js"></script>

## Conclusion

I hope this article helped you to deploy Change Tracking and Inventory for virtual machines in Azure. Now get to work creating alert rules on the new log data you are collecting. 🤓 I'd love to know how you are using CT in Azure and what benefits it offers you. Leave a comment or contact me over LinkedIn or email!

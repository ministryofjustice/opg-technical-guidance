---
category: Terraform
expires: 2019-11-20
---
# Terraform Modules

## Scope

This guide will set out when & how we should use Terraform modules.

## Overview

[Modules](https://www.terraform.io/docs/modules/index.html) in Terraform are self-contained packages of Terraform configurations that are managed as a group. Modules are used to create reusable components in Terraform as well as for basic code organization.

## Linked ADR

This guide references [ADR-0003-terraform-module-usage](https://github.com/ministryofjustice/opg-terraform/blob/master/doc/architecture/decisions/0003-terraform-module-usage.md).

# Guide 

## Remote Modules

Where possible, we must use modules from the Terraform registry.

We must pin modules from the [Terraform registry](registry.terraform.io) to major versions.

If you are writing a Terraform module aim to publish it as a public module with it's own test pipeline and repository, an exemplar repository is the [Terraform AWS VPC module](https://github.com/terraform-aws-modules/terraform-aws-vpc).

### When to write a Local Module

Local modules should be shareable across environments or for code reuse. For example, a Lambda that has different content but the same configuration otherwise would be a good candidate.

### Module Documentation & Testing

- Modules should contain usage documentation so that a user can understand how, and when to use the module.
- Documentation tools such as [terraform-docs](https://github.com/segmentio/terraform-docs) should be used for generating the inputs and outputs of modules.
- Annotate `inputs` and `outputs` using the description field.
- Unit test the module.
- A `README.md` that states its purpose and usage.

---
category: incidents
expires: 2021-01-01
---

# Introduction to incidents

Incidents sound scary, the term "incident" just means something is going wrong or
not working as expected. Incidents can happen anywhere, and we face technology outages
that will impact our users.

We can't stop incidents from happening, but we can make sure we are ready to deal
with them.

## What is incident response?
------

This is the broad term that refers to the processes we follow when something happens.
These are the things we should be thinking about apart from actually fixing the issue:

* Communicating with ourselves
* Communication with users
* Clearly defining roles
* Getting the right people involved
* Tracking what's happened


### Incident priority table

|Classification|Type|Example|Response time|Update frequency|
|---|---|---|---|---|
|P1|Critical|Complete outage, or ongoing unauthorised access|20 minutes|1 hour|
|P2|Major|Substantial degradation of service|60 minutes|2 hours|
|P3|Significant|Users experiencing intermittent or degraded service due to platform issue|2 hours |Once after 2 business days|
|P4|Minor|Component failure that does not immediately impact a service, or an unsuccessful DoS attempt|1 business day |Once after 5 business days|


## Guidance for products
------

The main incident response process is stored here in the `opg-technical-guidance`
respository. Each product should have product runbook also located in this repository,
you should create a link to this runbook from your repository in the `README.md`.

Runbook Template:

```
---
category: runbooks
expires: 2019-12-01
---
# Service Name Runbook

## Description

## Incident Response Hours

Currently we respond to incidents within the hours outlined below:

    9am-5pm, Monday to Friday, excluding bank holidays

## Incident contact details

* Product Manager:
* Delivery Manager:
* Service Owner:
* Technical Architect:
* Team:

### For Incidents involving data:

* OPG IA:
* MOJ IA:
* MOJ Cyber Security:

## URLs

### Service URLs

    https://development.example.gov.uk
    https://preproduction.example.gov.uk
    https://example.gov.uk

### Other URLs

#### Github

    https://github.com/ministryofjustice/example
    https://github.com/ministryofjustice/example

## Docs

You can find links to our technical documentation below:

## Service Team (non-urgent issues)

```

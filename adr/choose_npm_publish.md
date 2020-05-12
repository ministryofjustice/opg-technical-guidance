---
category: adrs
expires: 2020-11-05
---

# Choose NPM Publish

## Status

Accepted

## Context

As we split our code in microservices on the front-end, we need to have a way of sharing common code across products.

We have this issue currently with a few features we use over many products. This will give developers an option to share these features with others.

## Decision

Where possible, we should use NPM to publish any reusable code in our projects and consume them.

We already use NPM repositories for all our products. Integration isn't an issue when consuming the packages.

There will be a learning curve to setting up the repositories. This has been investigated already and can built upon.

An example of this can be found here in this package.

[https://www.npmjs.com/package/@ministryofjustice/opg-performance-analytics](https://www.npmjs.com/package/@ministryofjustice/opg-performance-analytics)

Using the above as a template we can have full CI/CD with granular control over releases.

## Consequences

This brings the following benefits

- Other teams can contribute to the same source code
- Reduces potential duplication of similar functionality across products
- Gives back to the open source community
- Get feedback from the wider community in making us better developers
- Modularised code for cleaner codebases and easier testing

The downside of this approach means development cycles may take longer. This is due to the extra work to build and publish the package. Long term the benefits you gain outweigh this initial cost.

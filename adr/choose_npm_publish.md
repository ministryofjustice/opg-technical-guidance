---
category: adrs
expires: 2020-11-05
---

# Choose NPM Repository Publish

## Status

Accepted

## Context

As we build more products with Javascript front-ends, we need to have a way of sharing common code across products to prevent duplication of code and encourage cross team collaboration.

We have this issue currently with a few features we use over many products. This can be seen in places such as the PDF Viewer in Sirius, Cookie Consent Banners in our public facing sites and custom GDS styled components across all platforms.

This will give developers an option to share these features with others.

## Decision

Where possible, we should publish any reusable code in our projects to a NPM Repository and consume them in our products.

We already use NPM repositories within our products for dependencies. For this we predominately use Yarn with a few instances of NPM to manage them.

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

The downsides of this approach are

- Development cycles will be longer initially due to the extra work to create the module
- There will be more repositories to maintain
- Potential loss of ownership if the code moves out of control of the product team
- Learning curve for those unfamiliar with the NPM and Javascript ecosystem

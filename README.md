# OPG Technical Guidance

👉 [https://docs.opg.service.justice.gov.uk](https://docs.opg.service.justice.gov.uk)

## DSL Structurizr Diagrams

You can find high level DSL Diagrams as Code in the [/dsl/poas](./dsl/poas/) directory.

## OPG Digital Technical Guidanace

This repository builds the documentation used by the OPG Digital team to track common patterns,approaches and guidelines.

This is a static site generated with Middleman. You can preview your changes with:

``` make
make preview
```

## Technical documentation template

This project uses [alphagov/tech-docs-template](https://github.com/alphagov/tech-docs-template).

This means that some of the files (like the CSS, javascripts and layouts) are
managed in the template and are not supposed to be modified here.

### Deployment

This project is hosted on GitHub Pages. It is [redeployed whenever a PR is merged][actions].

## Licence

[MIT License](LICENCE.md)

[actions]: https://github.com/ministryofjustice/opg-technical-guidance/blob/main/.github/workflows/publish.yml

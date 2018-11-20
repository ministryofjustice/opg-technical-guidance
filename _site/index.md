# OPG Technical Guidance

This site documents some of the technical decisions that the
[Office of the Public Guardian Digital](https://github.com/orgs/ministryofjustice/teams/opg) has made for the products we operate.

It complements the [Service Manual](https://www.gov.uk/service-manual),
which covers service design more broadly, and the [Ministry of Justice Technical Guidance](https://ministryofjustice.github.io/technical-guidance/#moj-technical-guidance)

## Guides

{% assign guides = site.pages
  | where: "guide", true
  | group_by: "category" %}

{% for guide_group in guides %}
{% if guide_group.name != "" %}
### {{ guide_group.name }}
{% else %}
### General guides
{% endif %}

{% for guide in guide_group.items %}
- [{{ guide.title }}]({{ guide.url | relative_url }})
{% endfor %}
{% endfor %}

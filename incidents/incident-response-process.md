---
category: incidents
expires: 2021-01-01
---

# Incident Response Process

This document describes our incident handling process (inspired by work elsewhere in MOJ like the Cloud Platform).

## Confirm that an event constitutes an incident
------

we define an incident as an event which:

* An event that requires immediate response to return normal service
* Severely degrades user experience of the service
* Compromise of application security, resulting in a breach or potential breach
* Potential for loss or compromise of data

Examples:

* Live service is unreachable due to denial of service
* Connectivity to a database is down and so services cannot be accessed.
* A problem in one service means another is no longer functioning i.e. api gateway in Sirius causing issues in Use An LPA
* Misconfiguration means that secrets are exposed on a live service
* Unauthorized access to an API which can result in attackers accessing data

## Declare an incident
------

From your teams channel you can use the OPG incidents slack tool to declare an incident.

`/opg-incident Something's happened`

You'll be prompted to fill in extra information in a GUI like this:

{{ }}

At this stage, just select if its a live incident or something you'd just like to report. All the other information can be filled in later.

The slack bot will automatically post a message into the `#opg-incidents` channel. **This marks the offical start of an incident**


### immediate first steps

As soon as the tool has posted a message into `#opg-incidents` you should do these steps immediatly

1. Hit the create communtications channel button in the message.
2. Page the on-call incident lead.

These steps should be done

## Ensure roles have been assigned
------

There are two roles that **must** be filled for every incident. They are the **incident Lead** and **incident Scribe**

> In rare cases, the same person might fill both roles but this is discouraged.

The incident lead should be someone from outisde your immediate team to provide another set of eyes thoughout the incident lifecycle. The scirbe can be someone in your team, ask for volunteers verbally or via slack, in the unlikey event you get no volnteers, appoint someone.

### Incident Reporter

This is whoever discovered the issue and declared the incident.

### Incident Lead

The incident reporter should call in a designated incident lead, typically a Technical Architect, Lead or Senior WebOps.

#### Responsibilities

* coordinate our response to the incident
* decide on any additional roles required (e.g. a communications lead may be required)
* ensure that all required roles are filled
* ensure that all tasks which need to be handled are being done
* make the final decision whenever we need to choose a course of action
* set the schedule for any regular team check-ins, if those are deemed necessary
* declare the incident closed, when appropriate
* ensure that the post-incident process is followed

> NB: The incident lead needs to ensure that things **are being done**, not try to do everything themselves.

Once appointed, the incident lead should update the following information using the slack bot in the deidcated communitcations channel.

* incident summary `@opg-incident summary <describe the incident>`
* incident severity `@opg-incident sev <Critical, Major, Trivial>`
* incident impact `@opg-incident impact <describe the impact>`

### Incident Scribe

#### Responsibilities

The scribe is responsible for keeping a log of the incident, including:

* important events
* discussion topics
* decisions
* actions
* results of actions/investigations

> NB: this log is not intended to be a verbatim transcript of discussions. Rather, things like "xxx suggested the disk might be full.
> yyy to investigate and report back"

Once appointed, the scribe should update the incident header at the top of the channel with a link to the living document on
`https://incident.opg.service.justice.gov.uk`

The scribe can pin important message in the incident channel and the slack tool will automatically add those into the timeline summary. They can also add
actions to the incdent log using the following command `@opg-incident action <action_description>`

Scribe takes notes during any shared calls and summarises in the incident channel.

### Communications Lead

Depending on the impact/duration/panic-level of an incident, it *may* be desirable to appoint a communications lead.
It is usually best if this is a member of the product profession to help with business side comms framing.

#### Responsibilities

* communicate the incident out to those who are impacted
* decide what, how and how often to issue updates
* give updates at regular intervals
* field enquiries so the team can focus on fixing the incident without interruptions
* disseminate a post-incident report

Comms lead can summarise technical details and ongoing actions from the dedicated incident channel back to the main incident channel to
keep interested parties up to date.

### Transferring roles

It may be necessary to transfer roles from one team member to another, e.g. during long-running incidents. In this case, it is the responsibility
of whoever is in a role to ensure that someone else takes it over.

Whoever assumes a role should announce it in the incident channel, so that the team is aware and updated

## Fixing the problem
------

Please bear in mind that not every incident requires the whole team to be involved (even if they all *want* to join in).

Things you may want to consider:

* Start a Google Meet call to hold ongoing discussions
* Swarm on the problem
* Step back if you are not contributing and you don't have one of the key roles.
* Bring in members of other teams with relevant knowledge
* Ask in #opg-all-team-digital, #opg-webops-community or #opg-developers for relevant experience from outside your team


## End the incident
------

When work on the problem has ceased, either because the problem has been resolved or because resolution is blocked until a later date,
the **incident lead** should update the slack tool to close the incident.

`@opg-incident close`

This marks the official end of the incident. If users were notified of the incident, an appropriate message should go out via the same channels
to tell them it's over.

## Post Incident
------

After the incident is resolved:

* Run a root cause analysis session to identify where we can improve
* Document the outcome in confluence
* Share with the delivery team and wider OPG Digital so they can learn from it too

## Records and retention
------

Incident channel should be archived once the issue is fixed.
Root cause analysis shared with the Amazon Technical Account Managers and leadership team.

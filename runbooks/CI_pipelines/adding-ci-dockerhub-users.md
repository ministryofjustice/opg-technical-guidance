---  
category: runbooks
expires: 2021-11-20
---

# Adding a service DockerID to CircleCI build

This runbook shows how to setup and use "service" DockerIDs to service CircleCI builds.  

## Context

as of 1st november 2020, anonymous pulls for docker images will be rate limited to 100 per 6 hours. There are higher rates for personal accounts and unlimited pulls for organisational accounts. See:

- [Scaling Docker to Serve Millions More Developers: Network Egress](https://www.docker.com/blog/scaling-docker-to-serve-millions-more-developers-network-egress/)
- [Authenticate with Docker to avoid impact of Nov. 1st rate limits](https://discuss.circleci.com/t/authenticate-with-docker-to-avoid-impact-of-nov-1st-rate-limits/37567)

This will significantly hamper our ability to run builds in CircleCI without action. in order to resolve this,CircleCI recommends to add docker hub authentication.

- see [Using Docker Authenticated Pulls](https://circleci.com/docs/2.0/private-images/)

Fortunately, we have access to a DockerHub organisation in the Ministry of Justice, which has free unlimited pulls of images.

## Security

We are not using [CircleCI contexts](https://circleci.com/docs/2.0/contexts/) as this is a shared organisational level construct, that any pipeline could use, and we're not set up with context restrictions at this time.
We need to ensure that each of the circleci projects has an individual DockerID and token added in [project level environment variables](https://circleci.com/docs/2.0/env-vars/#setting-an-environment-variable-in-a-project), reducing blast radius should it become compromised.

## Prerequisites

You will need:

- Your own Docker ID, which has been:
  - Added to the `ministryofjustice` dockerhub organisation as an owner.
  - added to the `opgdockerhubusers` team.
- Access to the OPG webops team google group email.
- Access to the project settings on the CircleCI project you are working on.

Ask one of your webops colleagues to help if you don't have details of these.

## Steps

there are 3 main steps:

1. Create a service Docker ID
2. Add service user to docker organisation and team
3. Add docker hub credentials to CircleCI

### 1. Create a service Docker ID

1. On hub.docker.com create a Docker ID, using:
   - A strong randomised password
   - A name that makes sense for the pipeline.
   - The email associated with OPG webops group, using a an `+` email alias to associate with the new Docker ID.
2. Take note of the above credentials and store in the webops secure vault for safekeeping.
3. Log out of hub.docker.com.
4. This will send a validation email to the opg team google group, but look out for one with the correct alias.  
5. Validate the email.
6. Once validated successfully, log back in with the new credentials
7. Go to the profile name, drop down to `Account Settings` and select `Security` on the screen.
8. In the Access Tokens click `New Access Token`.
9. Give the token a useful name e.g. `CircleCI access token` and click `Create`
10. on the next Dialog, Copy the access token provided.
11. paste into the relevant secure vault entry for safekeeping.
12. Click `Copy and Close`.

### 2. Add the service account to organisation and team

1. Log in to your own DockerID on hub.docker.com.
2. under Organisations click `ministryofjustice` and then click `Add Member`
3. Enter the DockerID of the new service user and select `opgdockerhubusers` from the dropdown
4. Click `Add`.

This user will have member permissions, which will be enough to pull images.

### 3. Add dockerhub credentials to CircleCI

1. go to the project settings of the circleci build pipeline
2. go to environment variables
3. Add an environment variable for the service DockerID e.g. `$DOCKER_USER`
4. Add an environment variable for the docker access token e.g. `$DOCKER_ACCESS_TOKEN`.
5. You should now be able to reference these inside of the `config.yaml` for CircleCI.
6. Follow the advice given in [using Docker Authenticated Pulls](https://circleci.com/docs/2.0/private-images/) to set up you pipeline with these credentials, when using environment variables.

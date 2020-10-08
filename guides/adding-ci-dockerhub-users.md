---  
category: circleci
expires: 2021-11-20
---

# Adding org dockerhub service users to support circleci builds

This guide will set out how to setup and use dockerhub "service" users to service circleci builds.  

## User Needs

as of 1st november 2020, anonymous pulls for docker images will be rate limited to 100 per 6 hours. There are higher rates for personal accounts and unlimited pulls for organisational accounts. See:

- [Scaling Docker to Serve Millions More Developers: Network Egress](https://www.docker.com/blog/scaling-docker-to-serve-millions-more-developers-network-egress/)
- [Authenticate with Docker to avoid impact of Nov. 1st rate limits](https://discuss.circleci.com/t/authenticate-with-docker-to-avoid-impact-of-nov-1st-rate-limits/37567)

We need to implement the recommendations by circleci to add authentication - see [using Docker Authenticated Pulls](https://circleci.com/docs/2.0/private-images/)

As this will significantly hamper our ability to run builds in CircleCI, this needs to be implemented.

Fortunately, we have access to a DockerHub organisation in the MoJ. the steps below show you how to go about creating and using a service user for OPG repos.

## Principles

We need to ensure that each of the circleci builds has an account and token associated to reduce blast radius should any of these DockerIDs become compomised.

## Tools

you will need:

- Your own Docker ID, which has been:
  - Added to `ministryofjustice` dockerhub organisation as an owner.
  - Inside the `opgdockerhubusers` team.
- Access to the OPG webops team google group.
- Access to the project settings on the CircleCI project you are working on.

Ask one of your webops colleagues to help if you don't have details of either of these.

## Steps 

there are 3 main steps:

1. Create a service user
2. Add service user to docker organisation and team
3. Add docker hub credentials to CircleCI

### 1. Create a service docker user

1. On hub.docker.com create an account, using:
   - A strong randomised password
   - A name that makes sense for the pipeline.
   - The email associated with OPG webops group, using a an `+` email alias to associate with your new docker ID.
2. Take note of the above credentials and store in the webops lastpass account.
3. This will send a validation email to the opg team google group, look out for one with the correct alias.  
4. Log out of hub.docker.com.
5. Validate the email, making sure you select the correct one delivered to the group.
6. Once validated successfully, log back in with your new credentials
7. Go to the profile name, drop down to `Account Settings` and select `Security` on the screen.
8. In the Access Tokens click `New Access Token`, which will open a new dialog.
9. Give the token a useful name e.g. `CircleCI access token` and click `Create`
10. on the next Dialog, Copy the access token shown using the copy button.
11. paste into the relevant lastpass entry for safekeeping.
12. Click `Copy and Close`.

### 2. Add the service account to organisation and team

1. Log in to your own dockerhub account
2. under Organisations click `ministryofjustice` and then click `Add Member`
3. Enter the DockerID of the new service user and select `opgdockerhubusers` from the dropdown
4. Click `Add`.

### 3. Add dockerhub credentials to circleCI

1. go to the project settings of the circleci build pipeline
2. go to environment variables
3. Add an environment variable for the docker user e.g. `$DOCKER_USER` and add the service Docker id in,
4. Add an environment variable for the docker access token e.g. `$DOCKER_ACCESS_TOKEN` and add the access token previously created.
5. You should now be able to reference these inside of the `config.yaml` for CircleCI.
6. Follow the advice given in [using Docker Authenticated Pulls](https://circleci.com/docs/2.0/private-images/)

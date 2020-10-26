## Digideps Runbook

**Last review date:** 25th Oct 2020

**Description:** A service for court appointed professional and lay deputies to report to the Office of the Public Guardian (OPG) on clients who are unable to manage their own affairs under the mental capacity act and the supervision of the aforementioned reports.

**Service URLs:** [https://complete-deputy-report.service.gov.uk/](https://complete-deputy-report.service.gov.uk/)

**Incident response hours:** 9am to 5pm Monday to Friday, excluding bank holidays, public holidays.

**Incident contact details:** Slack: [https://mojdt.slack.com/messages/C7YH87C3A](https://mojdt.slack.com/messages/C7YH87C3A) email: [digideps@digital.justice.gov.uk](digideps@digital.justice.gov.uk)

**Service team contact:** [digideps@digital.justice.gov.uk](digideps@digital.justice.gov.uk)

**Hosting environment:** 
- AWS - We can log an emergency call with [here](https://console.aws.amazon.com/support/home#/) and will get an immediate call back.	
- OPG Infra Account Details: [https://ministryofjustice.github.io/opg-new-starter/amazon.html#digideps]

**Other Web Addresses:**

|Name                           |Address                                                                                |
|-------------------------------|---------------------------------------------------------------------------------------|
| Admin                         |     https://admin.complete-deputy-report.service.gov.uk/                              |
| Healthcheck ELB               |     https://complete-deputy-report.service.gov.uk/manage/elb                          |
| Healthcheck Availability      |     https://complete-deputy-report.service.gov.uk/manage/availability                 |
| Healthcheck Pingdom           |     https://complete-deputy-report.service.gov.uk/manage/availability/pingdom         |
| Admin Healthcheck ELB         |     https://admin.complete-deputy-report.service.gov.uk/manage/elb                    |
| Admin Healthcheck Availability|     https://admin.complete-deputy-report.service.gov.uk/manage/availability           |
| Admin Healthcheck Pingdom     |     https://admin.complete-deputy-report.service.gov.uk/manage/availability/pingdom   |
| Repository                    |     https://github.com/ministryofjustice/opg-digideps                                 |
	

**Expected speed and frequency of releases:** Continuously. As and when required.

**Automatic alerts:**

| Alert               | Source     | Application     | Description                                                                                |
|---------------------|------------|-----------------|--------------------------------------------------------------------------------------------|
| Site Availability   | Cloudwatch | Front and Admin | Alerts on the availability of Api, Redis, Notify, Sirius, ClamAV and wkHtmlToPDf           |
| Critical PHP errors | Cloudwatch | Front and Admin | Alerts when we see critical PHP errors in logs                                             |
| Other PHP errors    | Cloudwatch | Front and Admin | Alerts on any non critical PHP errors                                                      |
| Response times      | Cloudwatch | Front and Admin | Alerts where we have continued above average response times based on anomoly detection     |
| Queued documents    | Cloudwatch | Front           | Alerts if documents have failed to sync after an hour since submission                     |
| 5xx errors in app   | Cloudwatch | Front and Admin | Alerts on when we have a status code of 5xx appear in the application logs                 |			
| 5xx from ALB        | Cloudwatch | Front and Admin | Alerts where the application load balancer receives a 5XX response                         |

**Impact of an outage:** Deputies will not be able to edit or submit their reports. OPG case management staff will not be able to view and review submitted reports. As a result there may be an increase in the number of calls from deputies to the OPG contact centre. Reputational impact to OPG if deputies can not submit reports. Potential for data loss with deputies who have started to fill information on a report and have not saved the data when the service goes down.

**Out of hours response types:** Out of hours notification, but no obligation to resolve until incident response hours. 

**Consumers of this service:** Sirius Supervision

**Services consumed by this:** GOV.UK Notify (call can be logged [here](https://www.notifications.service.gov.uk/support))

**Restrictions on access:** None for production, other environments and admin restricted to users on VPN, DOM1, OPG Wifi

**How to resolve specific issues:** Specific re-occurring issues will be fixed as bug fixes. However in the event that we are alerted to an issue, 
then we should first check the cloudwatch logs for our production log group thoroughly to identify the extent of the issue.

In the event that the issue is service affecting then we should follow the Incident process which can be found in this [repo](https://ministryofjustice.github.io/opg-technical-guidance/incidents/incident-response-process/#opg-incident-response-process).

As part of this process we may identify that we need to roll back to a previous version of the application in which case, use the rollback procedure in this [folder](https://github.com/ministryofjustice/opg-digideps/tree/main/docs/runbooks).

In the event that a simple fix forward or a rollback to a previous version of the application can't be performed then please check against disaster recovery document for recovery options for your [issue](https://github.com/ministryofjustice/opg-digideps/blob/main/docs/DISASTER_RECOVERY.md).








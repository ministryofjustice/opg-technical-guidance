workspace {

    model {
        !include https://raw.githubusercontent.com/ministryofjustice/opg-data-lpa-id/main/docs/architecture/dsl/local/lpaidSoftwareSystem.dsl
        !include persons.dsl
        mlpaOnlineContainer = softwareSystem "Make a Lasting Power of Attorney Online" "Allows users to draft a Lasting Power of Attorney online. [Owner: Modernising, Users: Vega]" "Web Browser, Modernising" {
            mlpaOnlineContainer_webapp = container "App" "Provides and delivers static content, business logic, routing, third party access and database access" "Go, HTML, CSS, JS" "Web Browser" {
                -> donor "interacts with"
                -> attorney "interacts with"
                -> certificateProvider "interacts with"
            }
            mlpaOnlineContainer_database = container "Database" "Stores actor information, Draft LPA details, access logs, etc." "DynamoDB" "Database"
            mlpaOnlineContainer_databaseMonitoringTelemetry = container "Monitoring and Telemetery" "Cloudwatch logs, X-Ray and RUM" "AWS Cloudwatch" "Database"
        }

        mlpaSiriusPublicAPI = softwareSystem "Case Management Public API" "Interaction point between Case Management and other services. [Owner: Vega, Users: UaLPA, Modernising]" "Existing System"

        mlpaOpgRegisterService = softwareSystem "Registered LPA Service" "Highly available API for reading and searching the LPA Register. [Owner: Vega, Users: UaLPA, Modernising]" "Container, Vega" {
            mlpaOpgRegisterService_ReadAPIGateway = container "Registered LPA Read API" "Highly available API for reading and searching the LPA Register " "API Gateway" "Container"
            mlpaOpgRegisterService_WriteAPIGateway = container "Registered LPA Write API" "Interface to writing to the Registered LPA Database." "API Gateway, Go" "Container"
            mlpaOpgRegisterService_ReadReplicaDatabase = container "Read Replica LPA Database" "Cached version of Registered LPA Data." "AuroraDB" "Database"
            mlpaOpgRegisterService_ReadReplicaMonitoringTelemetry = container "Monitoring and Telemetery" "Cloudwatch logs and X-Ray" "AWS Cloudwatch" "Database"
        }

        mlpaDraftingService = softwareSystem "LPA Drafting Container" "Stores and manages data for pre-registration. [Owner: Modernising, Users: Vega]" "Container, Modernising" {
            mlpaDraftingServiceDatabase = container "Draft LPA Database" "Stores Draft LPA data." "DynamoDB" "Database"
            mlpaDraftingServiceApp = container "App" "Manage events, data validation and business logic." "Go" "Component" {
                -> mlpaDraftingServiceDatabase "Uses"
                -> lpaUIDService "gets LPA Code from"
                -> mlpaOpgRegisterService_WriteAPIGateway "writes validated registered data to"
                -> mlpaSiriusPublicAPI "writes final registered case management data and triggers case working events to"
            }
            mlpaDraftingServiceAPI = container "API" "Manages LPA data validation and draft ingestion" "API Gateway, Go" "Component" {
                -> mlpaDraftingServiceApp "Uses"
            }
            mlpaDraftingServiceSiriusAPI = container "Case Management Integration API" "Manages API access for Case Management tasks" "API Gateway, Go" "Component" {
                -> mlpaDraftingServiceApp "Uses"
                -> mlpaSiriusPublicAPI "allows read access to draft data and write access to executed data"
            }
        }

        mlpaOpgRegisterDatabase = softwareSystem "Registered LPA Data Store" "Stores immutable LPA data with high availablility, security and auditing. [Owner: Modernising, Users: Vega]" "Modernising" {
            mlpaOpgRegisterDatabase_database = container "Database" "Stores final Register LPA Data." "AuroraDB" "Database"
            mlpaOpgRegisterDatabase_databaseMonitoringTelemetry = container "Monitoring and Telemetery" "Cloudwatch logs and X-Ray" "AWS Cloudwatch" "Database"
        }

        mlpaSupporterAPI = softwareSystem "Public LPA Support API" "Allows external companies to add submit LPAs. [Owner: Vega, Users: Modernising]" "Container, Modernising" {
            -> mlpaDraftingServiceAPI "makes calls to"
            -> thirdparty "interacts with"
        }

        mlpaPaperIngestionAPI = softwareSystem "LPA Paper Ingestion Service" "Handles the ingestion of the Paper Journey and exposes APIs for non valid OCR data for caseworker keying. [Owner: Modernising, Users: Vega]" "Container, Vega" {
            -> mlpaSiriusPublicAPI "reads and writes data from"
            -> mlpaDraftingServiceAPI "writes valid data to"
        }

        mlpaInternalPaymentService = softwareSystem "OPG Internal Payment Service" "Handles GOV.UK Pay and Remissions and Exemptions information between all services and Sirius. [Owner: Vega, Users: Modernising]" "Existing System, Vega"

        mlpaSiriusCaseManagement = softwareSystem "Case Management (Sirius)" "Case Management for case working LPAs. [Owner: Vega, Users: Modernising]" "Component, Vega" {
            -> caseWorker "interacts with"
            mlpaSiriusInternalAPI = container "Internal API" "" "API Gateway, PHP" "Existing System"
            mlpaSiriusDatabase = container "Database" "Stores Case Management data." "AuroraDB" "Database Existing System"
            mlpaSiriusMSPreRegistrationCaseManagement = container "Pre-Registered Case Management" "Microservice for Pre-Registered LPAs." "Go, HTML, CSS, JS"
            mlpaSiriusMSRegisteredCaseManagement = container "Registered Case Management" "Microservice for Registered LPAs." "Go, HTML, CSS, JS"
            mlpaSiriusMSPaperCaseManagement = container "Paper Channel Case Management" "Microservice for Paper Channel LPAs." "Go, HTML, CSS, JS"
        }

        // External Systems
        mlpaOPGAuthService = softwareSystem "OPG Authentication Service" "User facing central Authentication service. [Owner: UaLPA, Users: Modernising]" "Container, UaLPA"
        externalSoftwareSystems = softwareSystem "External Services" "GOV.UK Notify, Pay, One Login, Yoti, Ordanance Survey" "Existing System"
        externalScanningSoftware = softwareSystem "Scanning Software" "TBC" "Existing System"
        mlpaUaLPA = softwareSystem "Use an LPA" "Use/View an LPA Service. [Owner: UaLPA]" "Web Browser Existing System, UaLPA"

        externalScanningSoftware -> mlpaPaperIngestionAPI "sends scanned LPA Data to"

        mlpaOnlineContainer -> mlpaDraftingServiceAPI "makes calls to"
        mlpaSiriusCaseManagement -> lpaUIDService "gets LPA Code from"

        mlpaOnlineContainer -> mlpaOPGAuthService "authenticates with"
        mlpaUaLPA -> mlpaOPGAuthService "authenticates with"

        mlpaUaLPA -> mlpaSiriusPublicAPI "read data from"
        mlpaUaLPA -> mlpaOpgRegisterService_ReadAPIGateway "read data from"

        mlpaOpgRegisterService_WriteAPIGateway -> mlpaOpgRegisterDatabase_database "writes data to"
        mlpaOpgRegisterService_ReadAPIGateway -> mlpaOpgRegisterService_ReadReplicaDatabase "reads data from"
        mlpaOpgRegisterService_ReadReplicaDatabase -> mlpaOpgRegisterService_ReadReplicaMonitoringTelemetry "interacts with"
        mlpaOpgRegisterService_ReadReplicaDatabase -> mlpaOpgRegisterDatabase_database "syncs with"

        mlpaOpgRegisterDatabase_databaseMonitoringTelemetry -> mlpaOpgRegisterDatabase_database "interacts with"

        mlpaSiriusCaseManagement -> mlpaInternalPaymentService "writes and read data from"
        mlpaSiriusPublicAPI -> mlpaSiriusCaseManagement "writes and read data from"

        mlpaSiriusCaseManagement -> mlpaOpgRegisterService_ReadAPIGateway "reads data from"

        mlpaOnlineContainer_webapp -> mlpaOnlineContainer_database "reads and writes data to"
        mlpaOnlineContainer_database -> mlpaOnlineContainer_databaseMonitoringTelemetry "interacts with"
    }

    views {
        systemlandscape "SystemLandscape" {
            include *
            autoLayout
        }

        systemContext mlpaOnlineContainer {
            include *
            autoLayout
        }

        systemContext mlpaDraftingService "mlpaDraftingService" {
            include *
            autoLayout
        }

        container mlpaDraftingService "Containers" {
            include *
            autoLayout
        }

        container mlpaOnlineContainer "mlpaOnlineContainerContainers" {
            include *
            autoLayout
        }

        container lpaUIDService "lpaIDServiceContainers" {
            include *
            autoLayout
        }

        theme default

        styles {
            element "Existing System" {
                background #999999
                color #ffffff
            }
            element "Web Browser" {
                shape WebBrowser
            }
            element "Database" {
                shape Cylinder
            }
            element "Database Existing System" {
                background #999999
                color #ffffff
                shape Cylinder
            }
            element "Web Browser Existing System" {
                background #999999
                color #ffffff
                shape WebBrowser
            }
        }
    }
}

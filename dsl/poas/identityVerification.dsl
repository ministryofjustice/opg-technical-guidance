identityVerification = softwareSystem "OPG Identity Verification Service" "Responsible for verification options on internal and external services." {
    identityVerification_internalServices = container "Internal Identity Services" "Custom built Identity Services. e.g. UK Passport, UK Driver Licence, Bank Check, Open Banking, Vouching" "Go" "Component" {
        identityVerification_internalServices_businessLayer = component "Business Layer" "Handles calls to external APIs and appropriate logic for verification module." "Go" "Container"
        identityVerification_internalServices_caseManagementWeb = component "Case Management Web Interface" "Interface specifically for case workers." "Go, HTML, CSS, JS" "Web Browser" {
            -> identityVerification_internalServices_businessLayer
        }
        identityVerification_internalServices_selfManagementWeb = component "Self Management Web Interface" "Interface for public users." "Go, HTML, CSS, JS" "Web Browser" {
            -> identityVerification_internalServices_businessLayer
        }
        identityVerification_internalServices_router = component "Router" "Routes incoming traffic to the correct web application." "Go" "Container" {
            -> identityVerification_internalServices_selfManagementWeb
            -> identityVerification_internalServices_caseManagementWeb
        }
    }

    identityVerification_externalServices = container "External Identity Services." "These will redirect the user to third party sites. e.g. One Login, easyID" "Go" "Component" {
        identityVerification_externalServices_businessLayer = component "Routing" "Redirects to appropriate external service, passing back the response." "Go" "Container"
    }

    identityVerification_service = container "Identity Service" "Responsible for verification options on internal and external services." "Go" "Component" {
        identityVerification_service_webapp = component "Webapp entry point" "Handles authentication and redirects to internal or external version of the Identity Service asked for." "Go" "Web Browser" {
            -> identityVerification_externalServices
        }
        identityVerification_service_businessLayer = component "Business Layer" "Processes the data from each Identity Service to a common data model." "Go" "Component" {
            -> identityVerification_internalServices
        }
        identityVerification_service_database = component "Database" "Temporary store of data to manage the process through the service." "DynamoDB" "Database"

        identityVerification_service_webapp -> identityVerification_service_businessLayer
        identityVerification_service_businessLayer -> identityVerification_service_database
    }

    identityVerification_externalServices -> identityVerification_service_businessLayer
}

@isTest
public with sharing class OrgCleanerDashboardControllerTest {
    public static testmethod void testConfigurationCleanUp(){
    	OrgCleanerDashboardController o = new OrgCleanerDashboardController();
    	PageReference p = o.ConfigurationCleanUp();
    }
    public static testmethod void testDataCleanUp(){
    	OrgCleanerDashboardController o = new OrgCleanerDashboardController();
    	PageReference p = o.DataCleanUp();
    }
    
}
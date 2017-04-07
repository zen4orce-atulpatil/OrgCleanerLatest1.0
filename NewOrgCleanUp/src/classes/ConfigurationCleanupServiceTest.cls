@isTest
public with sharing class ConfigurationCleanupServiceTest {
    
    /*@testSetup static void methodName() {
		NewConfigurationCleanupService n = new NewConfigurationCleanupService();
	}*/
    
    public static testmethod void testGetConfigDetailsOne(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
    	n.CurrentConfig='Trigger';
    	n.GetConfigDetails();  
    }
    public static testmethod void testGetConfigDetailsTwo(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
    	n.CurrentConfig='ApexPage';
    	n.GetConfigDetails();  
    }
    //cover with webservice callout
    public static testmethod void testGetConfigDetailsThree(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
    	n.CurrentConfig='WorkflowRule';
    	Test.setMock(WebServiceMock.class, new WebServiceValdidationRule());
    	n.GetConfigDetails();  
    }
    //cover with webservice callout
    public static testmethod void testGetConfigDetailsFour(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
    	n.CurrentConfig='ValidationRule';
    	Test.setMock(WebServiceMock.class, new WebServiceValdidationRule());
    	n.GetConfigDetails();  
    }
    
    public static testmethod void testGetConfigDetailsFive(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
    	n.CurrentConfig='ApexClass';
    	n.GetConfigDetails();  
    }
    //atul
    public static testmethod void testGetConfigDetailsSix(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
    	n.CurrentConfig='CustomField';
    	n.GetConfigDetails();  
    }
    public static testmethod void testCleanConfigurationsOne(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
		n.ConfigurationList='01q28000000kJuS$TriggerOne';
		n.ConfigName='Trigger';
		n.CleanConfigurations();	    
    }
    public static testmethod void testCleanConfigurationsTwo(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
		n.ConfigurationList='01q28000000kJuS$PageOne';
		n.ConfigName='ApexPage';
		n.CleanConfigurations();	    
    }
    public static testmethod void testCleanConfigurationsThree(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
		n.ConfigurationList='01q28000000kJuS$OneWorkFlow';
		n.ConfigName='WorkflowRules';
        test.startTest();
		Test.setMock(WebServiceMock.class, new WebServiceImpl());
    	MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
		n.CleanConfigurations();
        test.stopTest();
    }
    public static testmethod void testCleanConfigurationsFour(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
		n.ConfigurationList='01q28000000kJuS$OneValidationRule';
        test.startTest();
		n.ConfigName='ValidationRules';
		Test.setMock(WebServiceMock.class, new WebServiceImpl());
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
		n.CleanConfigurations();
        test.stopTest();
    }
    public static testmethod void testCleanConfigurationsFive(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
		n.ConfigurationList='01q28000000kJuS$SamplClass';
		n.ConfigName='ApexClass';
		n.CleanConfigurations();	    
    }
    //atul
    /*public static testmethod void testCleanConfigurationsSix(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
		n.ConfigurationList='01q28000000kJuS$CustomFields';
        				 	
		n.ConfigName='CustomField';
		n.CleanConfigurations();	    
    }*/
    public static testmethod void testdependents(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
    	n.ConfigurationList='01q28000000kJuS$SamplClass';
    	n.dependents();
    }
    public static testmethod void testdeleteclasses(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
    	n.ConfigurationList='01q28000000kJuS$SamplClass';
    	n.deleteclasses();
    }
    public static testmethod void testDashboard(){
    	ConfigurationCleanupService n = new ConfigurationCleanupService();
    	PageReference p = n.Dashboard();
    }
   
   
}
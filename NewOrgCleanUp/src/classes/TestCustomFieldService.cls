@isTest
public with sharing class TestCustomFieldService {
	
	static testMethod void TestListOfAllObj()
	{
		List<String> lstOfObj = new List<String>();
		lstOfObj = CustomFieldService.listOfAllObj();
		System.assertEquals(true,lstOfObj.size()> 0);
	}
    static testMethod void TestListOfAllFields()
    {
    	Map<String,List<String>> lstOfFields = new Map<String,List<String>>();
		lstOfFields = CustomFieldService.listOfAllFields();
		System.assertEquals(true,lstOfFields.size()> 0);
    
    }
   static testMethod void TestAllFieldsOfObject()
   {
   		List<String> lstOfFieldString = CustomFieldService.allFieldsOfObject('Account');
   		System.assertEquals(true,lstOfFieldString.size()> 0);
   } 
  
     static testMethod void TestdeleteFields()
   {
   		List<String> lstOfFields = new List<String>();
   		List<MetadataService.DeleteResult> check = new List<MetadataService.DeleteResult>();
   		lstOfFields.add('Customer__c.abc__c');
   		lstOfFields.add('Customer__c.xyz__c');
   		Test.setMock(WebServiceMock.class, new WebServiceMockDel());
   		MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
   		check = metaDataPort.deleteMetadata('CustomObject', lstOfFields);
         test.startTest();
   		CustomFieldService.DeleteFields(lstOfFields);
        test.stopTest();
   		System.assertEquals(check.size() > 0 ,true);
   		
   		
   }
   @IsTest
	private static void coverGeneratedCodeCRUDOperations()
	{	
    	// Null Web Service mock implementation
        System.Test.setMock(WebServiceMock.class, new WebServiceValdidationRule());
        // Only required to workaround a current code coverage bug in the platform
        MetadataService metaDataService = new MetadataService();
        // Invoke operations         
        MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
	}
}
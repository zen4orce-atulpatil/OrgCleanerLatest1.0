@isTest
public with sharing class TestValidationRuleService {
	
	 @isTest
    public static void testgetValidationRules(){
    	Map<string, List<List<String>>> mapValidatioRule = new Map<string, List<List<String>>>();
    	Test.setMock(WebServiceMock.class, new WebServiceValdidationRule());
    	mapValidatioRule = ValidationRuleService.getValidationRules();
    	List<List<String>> lstOfValidationRules = new List<List<String>>();
    	lstOfValidationRules = mapValidatioRule.get('Customer__c');
    	System.assertEquals(lstOfValidationRules.size() > 0,true);
    }
    @isTest
    public static void testdeleteValidationRules(){
        Test.setMock(WebServiceMock.class, new WebServiceMockDel());
    	List<String> selectedValidationRules = new List<String>();
    	List<MetadataService.DeleteResult> check = new List<MetadataService.DeleteResult>();
    	selectedValidationRules.add('ValidationRuleOne');
    	selectedValidationRules.add('ValidationRuleTwo');
    	MetadataService.MetadataPort metaDataPort = new MetadataService.MetadataPort();
    	
   		check = metaDataPort.deleteMetadata('ValidationRule', selectedValidationRules);
    	ValidationRuleService.deleteValidationRules(selectedValidationRules);
    	System.assertEquals(1,check.size() );
        System.assertEquals('Not - Found', check[0].errors[0].message);
    }
}
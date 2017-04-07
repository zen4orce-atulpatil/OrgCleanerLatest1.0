public with sharing class ValidationRuleService {
	public static Map<string, List<List<String>>> getValidationRules()
    {
    	Map<string, List<List<String>>> ValidationRuleMap = new Map<string, List<List<String>>>();
    	MetadataAPI mapi = new MetadataAPI();
        MetadataService.FileProperties[] fileproperties = mapi.listValidationRuleMetadata();
        System.debug('fileproperties ==>'+fileproperties);
        if(fileproperties != null){
        	list<String> ValidationRuleName;
            list<List<String>> ValidationRuleName1;
            System.debug('In this');
    		for(MetadataService.FileProperties fileProperty : fileproperties)
    		{
                System.debug('fileProperty -->'+fileProperty);
	    		if(fileProperty.fullName != null && fileProperty.fullName != '')
    	        {
                    System.debug('ValidationRuleMap ==>'+ValidationRuleMap);
                    System.debug('fileProperty ==>'+fileProperty);
        	        ValidationRuleName = new List<String>();  
                    ValidationRuleName1 = new List<List<String>>();
            	    string Objectname = fileProperty.fullName;
                    System.debug('Objectname =>'+Objectname);
                	if(ValidationRuleMap.containsKey(Objectname.substringBefore('.')))
                	{ 
                        System.debug('In If block');
                        System.debug('Objectname -->'+Objectname);
                        System.debug('ValidationRuleMap =>'+ValidationRuleMap);
                    	ValidationRuleName1.addAll(ValidationRuleMap.get(Objectname.substringBefore('.')));
                    	ValidationRuleName.add(Objectname.substringAfter('.'));  
                        ValidationRuleName.add(fileProperty.ID); 
                        ValidationRuleName1.add(ValidationRuleName);
                	}
                	else{
                        System.debug('Else Block');
	                    ValidationRuleName.add(Objectname.substringAfter('.'));
                        ValidationRuleName.add(fileProperty.ID); 
                        ValidationRuleName1.add(ValidationRuleName);
                        system.debug('v ==>');
    	            }
        	       	ValidationRuleMap.put(Objectname.substringBefore('.'), ValidationRuleName1); 
                    System.debug('ValidationRuleMap =>'+ValidationRuleMap);
    			}
    		}
        }
    	return ValidationRuleMap;         
    }
    public static void deleteValidationRules(List<String> selectedValidationRules)
    {
        system.debug('************ValidationRuleService deleteValidationRules************'+selectedValidationRules);
        Map<string, List<String>> validationRulesMap = new Map<string, List<String>>();
        validationRulesMap.put('ValidationRule', selectedValidationRules);
        Id batchJobId = database.executeBatch(new ConfigurationCleanUpBatchService(validationRulesMap),100);
        System.debug('batchJobId Validation Rule- ' + batchJobId);
        
        //MetadataAPI mapi = new MetadataAPI();
        //mapi.deleteWorkflow(selectedWorkflows);
    }
}
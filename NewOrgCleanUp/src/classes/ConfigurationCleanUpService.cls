public with sharing class ConfigurationCleanUpService {
    
    public List<ApexPage> visualforcePageList {get; set;}
    public List<ApexClass> apexClassList {get; set;}
    public Map<string, List<List<string>>> apexTriggerDetailMap = new Map<string, List<List<string>>>();
    public Map<string, List<List<string>>> workflowDetailMap = new Map<string, List<List<string>>>();
    public Map<string, List<List<String>>> validationRuleDetailMap = new Map<string, List<List<string>>>();
    public Map<String, List<String>> customFieldListMap = new Map<String,List<String>>();
    public Map<String, Set<String>> standardObjListMap = new Map<String,Set<String>>();
    public List<String> customObjList = new List<String>();
    public String triggersJson{get; set;}
    public String apexPageJson{get; set;}
    public String workflowJson{get; set;}
    public String validationRuleJson{get; set;}
    public String apexClassJson{get; set;}
    public String customFieldJson{get; set;}
    public String dependentClassesJson{get; set;}
    public String dependentPagesJson{get; set;}
    public String dependentTriggersJson{get; set;}
    
    public String ConfigurationList{get; set;}
    public String ConfigName {get; set;}
    public String CurrentConfig {get; set;}
    public List<String> triggerParentList {get;set;}
    public Boolean IsTrigger {get; set;}
    public Boolean IsApexPage {get; set;}
    public Boolean IsWorkflowRule {get; set;}
    public Boolean IsValidationRule {get; set;}
    public Boolean IsApexClass {get; set;}
    public Boolean IsCustomField {get; set;}
    
    public List<String> lstDependentClasses {get; set;}
    public List<String> lstDependentPages {get; set;}
    public List<String> lstDependentTriggers {get; set;}
    public List<ApexClass> lstclasses {get; set;}
   
    public List<String> selectedClasses;
    
    public PageReference Dashboard(){
        return Page.OrgCleanerDashboard;
    }
       
    public void GetConfigDetails(){
        if(CurrentConfig == 'Trigger'){  
            IsTrigger = true;
            getTriggersDetails();
            triggersJson = ConfigurationCleanUpServiceHandler.generateJsonForTrigger(apexTriggerDetailMap);
        } 
        else if(CurrentConfig == 'ApexPage'){
            IsApexPage = true;
            getVisualforcePages();
            apexPageJson = ConfigurationCleanUpServiceHandler.generateJsonForApexPage(visualforcePageList);
        }
        else if(CurrentConfig == 'WorkflowRule'){
            IsWorkflowRule = true;
            getWorkflows();         
            workflowJson = ConfigurationCleanUpServiceHandler.generateJsonForTrigger(workflowDetailMap);
        }
        else if(CurrentConfig == 'ValidationRule'){
            IsValidationRule = true;
            getValidationRules();           
            validationRuleJson = ConfigurationCleanUpServiceHandler.generateJsonForTrigger(validationRuleDetailMap);
        }
        else if(CurrentConfig == 'ApexClass'){
            IsApexClass = true;
            getApexClass();
            apexClassJson = ConfigurationCleanUpServiceHandler.generateJsonForApexClass(apexClassList);
        }
        else if(CurrentConfig == 'CustomField'){
            IsCustomField = true;
            getCustomFields();
            customFieldJson = ConfigurationCleanUpServiceHandler.generateJsonForCustomField(customFieldListMap);
        }
    }
   
    public void getTriggersDetails(){
        apexTriggerDetailMap = TriggerService.getTriggers();
        triggerParentList = new List<String>();
        triggerParentList.addAll(apexTriggerDetailMap.keySet());
    }
    public void getWorkflows(){
        workflowDetailMap = WorkflowService.getMetadataFor('Workflow'); 
    }
    public void getApexClass(){
        apexClassList = ApexClassService.getClasses(); 
    }
    
    public void getVisualforcePages(){
    	ConfigurationSelector configurationSelectorInstance = new ConfigurationSelector();      
        visualforcePageList = configurationSelectorInstance.getVisualforcePages();
    } 
    
    public void getValidationRules(){
        validationRuleDetailMap = WorkflowService.getMetadataFor('ValidationRule');
    }
    public void getCustomFields(){
        customFieldListMap = CustomFieldService.listOfAllFields();
    }
    public void CleanConfigurations(){ 
    	
        if(ConfigName == 'Trigger'){
            List<String> triggersToDelete = new List<String>();
            for(String details:ConfigurationList.split(',')){
                triggersToDelete.add(details.split('\\$')[1]);
            }
            
            TriggerService.deleteTrigger(triggersToDelete);
        }
        else if(ConfigName == 'ApexPage'){
            List<String> ApexPageToDelete = new List<String>();
            for(String details:ConfigurationList.split(',')){
                ApexPageToDelete.add(details.split('\\$')[0]);
            }
            ApexPageService.deleteApexPages(ApexPageToDelete);
        }
        else if(ConfigName == 'WorkflowRules'){
            
            ConfigurationSelector configurationSelectorInstance = new ConfigurationSelector();
        	string nameSpace = configurationSelectorInstance.nameSpaceprefixOfOrg(); 
            List<String> WorkflowRuleToDelete = new List<String>();
            for(String details:ConfigurationList.split(',')){
        		        		
        		if( nameSpace != null ){
        		
        			if( details.split('\\$')[0].endsWithIgnoreCase('__c')){
  						
  						 WorkflowRuleToDelete.add(nameSpace+'__'+details.split('\\$')[0]+'.'+nameSpace+'__'+details.split('\\$')[2]);
                	}
                	else{
                		
                		WorkflowRuleToDelete.add(details.split('\\$')[0]+'.'+nameSpace+'__'+details.split('\\$')[2]);
                	}                
        		} 
        		else{
        			
        			WorkflowRuleToDelete.add(details.split('\\$')[0]+'.'+details.split('\\$')[2]);
        		}                
            } 
            WorkflowService.deleteWorkflows(WorkflowRuleToDelete);          
             
        }
        else if(ConfigName == 'ValidationRules'){
        	
        	ConfigurationSelector configurationSelectorInstance = new ConfigurationSelector();
        	string nameSpace = configurationSelectorInstance.nameSpaceprefixOfOrg(); 
            List<String> ValidationRuleToDelete = new List<String>();
            for(String details:ConfigurationList.split(',')){
                //ValidationRuleToDelete.add('OrgCleaner__'+details.split('\\$')[0]+'.'+'OrgCleaner__'+details.split('\\$')[2]); 
            	
            	if( nameSpace != null ){
        		
        			if( details.split('\\$')[0].endsWithIgnoreCase('__c')){
  						
  						 ValidationRuleToDelete.add(nameSpace+'__'+details.split('\\$')[0]+'.'+nameSpace+'__'+details.split('\\$')[2]);
                	}
                	else{
                		
                		ValidationRuleToDelete.add(details.split('\\$')[0]+'.'+nameSpace+'__'+details.split('\\$')[2]);
                	}                
        		} 
        		else{
        			
        			ValidationRuleToDelete.add(details.split('\\$')[0]+'.'+details.split('\\$')[2]);
        		}               
            }
            WorkflowService.deleteValidationRules(ValidationRuleToDelete);            
            
        }
        else if(ConfigName == 'ApexClass'){
            List<String> ApexClassToDelete = new List<String>();
            for(String details:ConfigurationList.split(',')){
               
                ApexClassToDelete.add(details.split('\\$')[1]);
            } 
        }
        else if(ConfigName == 'CustomField')
        {	
        	ConfigurationSelector configurationSelectorInstance = new ConfigurationSelector();
        	string nameSpace = configurationSelectorInstance.nameSpaceprefixOfOrg(); 
            List<String> customFieldToDelete = new List<String>();
            
            for(String details:ConfigurationList.split(','))
            {	
            	if( nameSpace != null ){
        		
        			if( details.split('\\$')[0].endsWithIgnoreCase('__c')){
  						
  						 customFieldToDelete.add(nameSpace+'__'+details.split('\\$')[0]+'.'+details.split('\\$')[2]);
                	}
                	else{
                		
                		customFieldToDelete.add(details.split('\\$')[0]+'.'+details.split('\\$')[2]);
                	}                
        		} 
        		else{
        			
        			customFieldToDelete.add(details.split('\\$')[0]+'.'+details.split('\\$')[2]);
        		}        
            }
            CustomFieldService.deleteFields(customFieldToDelete);
        }
    }
    public void deleteclasses()
    {

        map<Id,String> mapClassNameandId = new map<Id,String>();  
        for(String s:ConfigurationList.split(','))
        {
            mapClassNameandId.put(s.split('\\$')[0],s.split('\\$')[1]); 
        }
        ConfigurationCleanUpServiceHandler.deleteclasses(mapClassNameandId,lstDependentClasses,lstDependentTriggers,lstDependentPages);
    }
    
    public void dependents(){ 
        selectedClasses=new List<String>();
        for(String s:ConfigurationList.split(','))
        {
            
            if(s.split('\\$').size() > 1 ){
            
                selectedClasses.add(s.split('\\$')[1]);
            }
        }
        lstDependentClasses=ApexClassService.getDependentClasses(selectedClasses);
        lstDependentPages=ApexClassService.getDependentPages(selectedClasses);
        lstDependentTriggers=ApexClassService.getDependentTriggers(selectedClasses);
        ConfigurationCleanUpServiceHandler.generateJson(lstDependentClasses);
        dependentClassesJson=ConfigurationCleanUpServiceHandler.generateJson(lstDependentClasses);//5 APRIL 17 - ATUL
        dependentPagesJson=ConfigurationCleanUpServiceHandler.generateJson(lstDependentPages);
        dependentTriggersJson=ConfigurationCleanUpServiceHandler.generateJson(lstDependentTriggers);
    }
}
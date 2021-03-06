public class MetadataAPI {
    
    //RETRIVING WORKFLOW RULE
    public MetadataService.FileProperties[] listWorkflowMetadata()
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();
        MetadataService.ListMetadataQuery queryWorkflow = new MetadataService.ListMetadataQuery();
        queryWorkflow.type_x = 'WorkflowRule';
        queries.add(queryWorkflow);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 25);
		
        return fileProperties;
    }
    
    //RETRIVE VALIDATION RULE
    public MetadataService.FileProperties[] listValidationRuleMetadata()
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();
        MetadataService.ListMetadataQuery queryValidationRule = new MetadataService.ListMetadataQuery();
        queryValidationRule.type_x = 'ValidationRule';
        queries.add(queryValidationRule);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 25);
        
        return fileProperties;
    }
    /*
    //RETRIVE CUSTOM FIELDS
    public MetadataService.FileProperties[] listFieldsMetadata()
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();
        MetadataService.ListMetadataQuery queryValidationRule = new MetadataService.ListMetadataQuery();
        queryValidationRule.type_x = 'CustomField';
        queries.add(queryValidationRule);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 25);
        
        return fileProperties;
    }
    
    //RETRIVE CUSTOM OBJECTS
    public MetadataService.FileProperties[] listObjectsMetadata()
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();
        MetadataService.ListMetadataQuery queryValidationRule = new MetadataService.ListMetadataQuery();
        queryValidationRule.type_x = 'CustomObject';
        queries.add(queryValidationRule);
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, 25);
       
        return fileProperties;
    }
    
    //DELETE CUSTOM FIELDS
    public Boolean deleteField(List<String> fieldList)
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results = service.deleteMetadata('CustomField', fieldList);
        handleDeleteResults(results[0]);
        return results.size() > 0 ? results[0].success : false;
    }*/
    /*
    //DELETE CUSTOM OBJECTS
    public Boolean deleteObject(List<String> objectList){
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results = service.deleteMetadata('CustomObject', objectList);
        handleDeleteResults(results[0]);
        return results.size() > 0 ? results[0].success : false;
    }*/
    
    //DELETE WORKFLOW RULE
    public Boolean deleteWorkflow(List<String> workflowList,String sessionID){
    	System.debug('workflowList 1 - ' + workflowList);
        MetadataService.MetadataPort service = createServiceBatch(sessionID);
        System.debug('sessionID- ' + sessionID);
        List<MetadataService.DeleteResult> results =  new List<MetadataService.DeleteResult>();
        try{
        	system.debug('**************metadata try******************');
        	results = service.deleteMetadata('WorkflowRule', workflowList);
        }
        catch(exception e){
        	system.debug('**************metadata try******************'+e.getMessage());
        }
        for(MetadataService.DeleteResult dr : results) {
    		/*if (dr.isSuccess()) {
        		// Operation was successful, so get the ID of the record that was processed
        		System.debug('Successfully deleted account with ID: ' );
    		}
    		else {*/
        		// Operation failed, so get all errors                
	        System.debug('Account fields that affected this error: ' + dr);
    	//}	
	}
        
        
        handleDeleteResults(results[0]);
        System.debug('results[0] - ' + results[0].fullName);
        return results.size() > 0 ? results[0].success : false;
    }
     //DELETE WORKFLOW RULE
   
    /*
    //DELETE VALIDATION RULE
    public Boolean deleteValidationRule(List<String> validationList){
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results = service.deleteMetadata('ValidationRule', validationList);
        handleDeleteResults(results[0]);
        return results.size() > 0 ? results[0].success : false;
    }*/
    //DELETE VALIDATION RULE
    public Boolean deleteValidationRule(List<String> validationList,String sessionID){
    	system.debug('***********************mata validationList************ '+validationList);
    	system.debug('***********************mata sessionID************ '+sessionID);
        MetadataService.MetadataPort service = createServiceBatch(sessionID);
        List<MetadataService.DeleteResult> results = service.deleteMetadata('ValidationRule', validationList);
        system.debug('***********************mata results************ '+results.size());
        handleDeleteResults(results[0]);
        return results.size() > 0 ? results[0].success : false; 
    }
    /*
    //DELETE FLOW 
    public Boolean deleteFlow(List<String> flowList){
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results = service.deleteMetadata('Flow', flowList);
        handleDeleteResults(results[0]);
        return results.size() > 0 ? results[0].success : false;
    }

    //DELETE STATIC RESOURCE
    public Boolean deleteStaticResource(List<String> packageList)
    {
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results = service.deleteMetadata('StaticResource', packageList);
        handleDeleteResults(results[0]);
        return results.size() > 0 ? results[0].success : false;
    }*/
    //Delete custom field
	public List<String> deleteField(List<String> lstOfMaps,String sessionID)
    {
        MetadataService.MetadataPort service = createServiceBatch(sessionID);
        System.debug(service);
        List<MetadataService.DeleteResult> results =
            service.deleteMetadata(
                'CustomField',lstOfMaps );
        List<String> messages =  handleDeleteResults(results);
        return messages;
   	}
    public static List<String> handleDeleteResults(List<MetadataService.DeleteResult> deleteResult)
    {	
        List<String> messages = new List<String>();
        for(MetadataService.DeleteResult res : deleteResult)
        {
       		 if(res.errors!=null)
             {
                 messages.add('\n'+res.fullName + ':');
                 for(MetadataService.Error error : res.errors)
                     messages.add(
                         error.message + ' (' + error.statusCode + ').' +
                         ( error.fields!=null && error.fields.size()>0 ?
                          ' Fields ' + String.join(error.fields, '.') + '.' : '' ) );
             }
        }
      
        return messages;
    }
    /*
	//UNINSTALL PACKAGES
    public Boolean uninstallPackages(List<String> packageList)
    {
        // Uninstall packages
        MetadataService.MetadataPort service = createService();
        List<MetadataService.DeleteResult> results =
            service.deleteMetadata('InstalledPackage', packageList);
        handleDeleteResults(results[0]);
		return results.size() > 0 ? results[0].success : false;
    } */
    
    public class MetadataServiceExamplesException extends Exception { }

    public static MetadataService.MetadataPort createService()
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }
    public static MetadataService.MetadataPort createServiceBatch(string sessionId)
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = sessionId;
        return service;
    }

    /**
     * Example helper method to interpret a SaveResult, throws an exception if errors are found
     **/
    /*
    public static void handleSaveResults(MetadataService.SaveResult saveResult)
    {
        // Nothing to see?
        if(saveResult==null || saveResult.success)
            return;
        // Construct error message and throw an exception
        if(saveResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (saveResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + saveResult.fullName + '.');
            for(MetadataService.Error error : saveResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
        }
        if(!saveResult.success)
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }

    /**
     * Example helper method to interpret a SaveResult, throws an exception if errors are found
     **/
    public static void handleDeleteResults(MetadataService.DeleteResult deleteResult)
    {
        // Nothing to see?
        if(deleteResult==null || deleteResult.success)
            return;
        // Construct error message and throw an exception
        if(deleteResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (deleteResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + deleteResult.fullName + '.');
            for(MetadataService.Error error : deleteResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
        }
        if(!deleteResult.success)
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }
    /*Creating apex pages in bulk*/
    /*
	public static void createPage(string fullName, string label)
    {
        MetadataService.MetadataPort service = createService();
        MetadataService.ApexPage apexPage = new MetadataService.ApexPage();
        apexPage.apiVersion = 25;
        apexPage.fullName = fullName;
        apexPage.label = label;
        apexPage.content = EncodingUtil.base64Encode(Blob.valueOf('<apex:page/>'));
        List<MetadataService.SaveResult> results =
            service.createMetadata(
                new MetadataService.Metadata[] { apexPage });
        handleSaveResults(results[0]);
    } */
    
    public class deleteMetadata_element {
        public String type_x;
        public String[] fullNames;
        private String[] type_x_type_info = new String[]{'type','http://soap.sforce.com/2006/04/metadata',null,'1','1','false'};
        private String[] fullNames_type_info = new String[]{'fullNames','http://soap.sforce.com/2006/04/metadata',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/2006/04/metadata','true','false'};
        private String[] field_order_type_info = new String[]{'type_x','fullNames'};
    }
    
    public class deleteMetadataResponse_element {
        public MetadataService.DeleteResult[] result;
        private String[] result_type_info = new String[]{'result','http://soap.sforce.com/2006/04/metadata',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/2006/04/metadata','true','false'};
        private String[] field_order_type_info = new String[]{'result'};
    }
}
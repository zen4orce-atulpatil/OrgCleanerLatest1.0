global class WebServiceImpl implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) 
         {	
       		{
       		MetadataService.deleteMetadataResponse_element res = new MetadataService.deleteMetadataResponse_element();
        	MetadataService.DeleteResult delRes = new MetadataService.DeleteResult();
        	List<MetadataService.Error> err = new List<MetadataService.Error>();
        	MetadataService.Error resultOfError = new MetadataService.Error();
        	resultOfError.statusCode = '204';
        	resultOfError.message = 'Not - Found';
        	List<String> ListOfFields = new List<String>();
        	ListOfFields.add('Customer__c.abc__c');
        	resultOfError.fields = ListOfFields;
        	err.add(resultOfError);
        	delRes.errors = err;
        	//res.result[0] = delRes;
            response.put('response_x', res);
       		}
       	 
       		
       	  
   	      }
}
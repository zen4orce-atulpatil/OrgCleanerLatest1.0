global class WebServiceMockDel implements  WebServiceMock{
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
         
       	 //if(request instanceof MetadataService.DeleteResult)
       		{
       		MetadataService.deleteMetadataResponse_element res = new MetadataService.deleteMetadataResponse_element();
        	List<MetadataService.DeleteResult> del = new List<MetadataService.DeleteResult> ();
        	MetadataService.DeleteResult delRes = new MetadataService.DeleteResult();
        	delRes.fullName = 'Customer__c.abc__c';
        	List<MetadataService.Error> err = new List<MetadataService.Error>();
        	MetadataService.Error resultOfError = new MetadataService.Error();
        	resultOfError.statusCode = '204';
        	resultOfError.message = 'Not - Found';
        	List<String> ListOfFields = new List<String>();
        	ListOfFields.add('Customer__c.abc__c');
        	resultOfError.fields = ListOfFields;
        	err.add(resultOfError);
        	delRes.errors = err;
        	del.add(delRes);
        	res.result = del;
        	
        	//res.result = del;
            response.put('response_x', res);
            //response_map_x.put('response_x', res);
       		}
       	 
    
}
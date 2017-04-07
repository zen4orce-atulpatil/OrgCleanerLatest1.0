@isTest
global  class WebServiceValdidationRule implements WebServiceMock {
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
	           MetadataService.listMetadataResponse_element metaDataRes = new MetadataService.listMetadataResponse_element();
	           List<MetadataService.FileProperties> lstFilePop = new List<MetadataService.FileProperties>();
	           MetadataService.FileProperties filePop = new MetadataService.FileProperties ();
	           filePop.fullName = 'Customer__c.ValidationRuleOne';
	           filePop.ID = '12345678';
	           MetadataService.FileProperties filePop1 = new MetadataService.FileProperties ();
	            filePop1.fullName = 'Customer__c.ValidationRuleOne';
	           filePop1.ID = '123456578';
	           lstFilePop.add(filePop);
	           lstFilePop.add(filePop1);
	           metaDataRes.result = lstFilePop;
	           response.put('response_x',metaDataRes); 
           }   
}
global with sharing class CommentDependentPagesBatch implements Database.Batchable<String>, Database.Stateful, Database.AllowsCallouts{
	
	
	public List<String> lstFailedPages=new List<String>();
	public List<String> lstClassesToDelete=new List<String>();
	public List<String> lstPagesToComment=new List<String>();
	public String sessionId='';
	global CommentDependentPagesBatch(List<String> typeWiseMap,string sess){
		sessionId=sess;
		lstPagesToComment=typeWiseMap;
		//lstClassesToDelete=lstClassesForDelete;
	}
	
	global List<String> start(Database.BatchableContext BC){
		
		return lstPagesToComment;	
    }
    global void execute(Database.BatchableContext BC, List<String> scope){	
        try{
        		    		
    		for(String s:CommentDependents.CommentMultiplePages(scope,sessionId))
    		{	
    			
    			lstFailedPages.add(s);
    		}        		
        }
        catch(Exception e){
        	System.debug('Error:'+e);
        }
        	
    }
    global void finish(Database.BatchableContext BC){
    		ConfigurationSelector configurationSelectorInstance = new ConfigurationSelector();
    		System.debug('Inside CommentDependentPagesBatch finish');
    		String body;
	    	if(lstFailedPages.size()>0){
	    		body='Page='+lstFailedPages+' are not commented and will give errors while you compile. Please Comment these mannually';
	    	}
	    	else{
	    		body='All Pages are commented Successfully';
	    	}
	    	Id idOfCurrentBetch = BC.getJobId();
	        //List<AsyncApexJob> lstAsyncApexJob = new List<AsyncApexJob>();
	        List<ApexClass> lstclasses=new List<ApexClass>();
	        AsyncApexJob lstAsyncApexJob = configurationSelectorInstance.asyncApexJobDetails(idOfCurrentBetch);
	        AsyncApexJob a=lstAsyncApexJob;
	    	Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	    	String[] toAddresses;
	    	/*if(Test.isRunningTest()){
	    		toAddresses = new String[] {'abc@gmail.com'};
	    	}
	    	else{*/
				toAddresses = new String[] {a.CreatedBy.Email};	    	
	    	//}
	        mail.setToAddresses(toAddresses);
	        mail.setSubject('Details of Pages failed to Comment');
			mail.setPlainTextBody(body);
			Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }		    
}
global with sharing class DeleteclassesBatch implements Database.Batchable<Id>, Database.Stateful, Database.AllowsCallouts{
	public List<Id> lstClassesToDelete;  
	public String sessionId='';// = UserInfo.getSessionId();
	public List<String> lstClassesFailedToDelete=new List<String>();
	public map<Id,String> mapIdName;
	global DeleteclassesBatch(map<Id,String> classNameIdMap,string sess)
	{
		sessionId = sess;
		System.debug('In Cons sessionId DeleteCLassBatch='+sessionId);
		lstClassesToDelete=new List<Id>();
		//lstClassesToDelete=lstClassesForDelete;
		mapIdName = new map<Id,String>();
		mapIdName.putAll(classNameIdMap);
	}
	
	global List<Id> start(Database.BatchableContext BC){
		//sessionId=UserInfo.getSessionId();
		System.debug('In Start method sessionId '+sessionId);
		List<Id> lstIds = new List<Id>();
		lstClassesToDelete.addAll(mapIdName.keySet());
        return lstClassesToDelete;
    }
    global void execute(Database.BatchableContext BC, List<Id> scope){	
        try{
        	ToolingAPIService t = new ToolingAPIService();
        	String deletionStatus;
        	for(Id a:scope)
        	{
        		deletionStatus=t.ClassDelete(a,sessionId);
        		System.debug('deletionStatus='+deletionStatus);
        		if(deletionStatus!='No Content')
        		{
        			lstClassesFailedToDelete.add(mapIdName.get(a));
        		}
        	}
        	System.debug('lstClassesFailedToDelete='+lstClassesFailedToDelete);
        }
        catch(Exception e){
        	System.debug('Error in Batch'+e.getMessage());
        }
    }
    global void finish(Database.BatchableContext BC){
    	Configurationselector configurationSelectorInstance = new Configurationselector();
    	String body;
    	if(lstClassesFailedToDelete.size()>0) 
    	{
	    	body='Due to some reason classes='+lstClassesFailedToDelete+'are failed to delete.';
    	}
    	else
    	{
		    body='Classes you were selected to delete are deleted successfully.';
    	}
    	System.debug('Email Body='+body);
    	Id idOfCurrentBetch = BC.getJobId();
	    AsyncApexJob lstAsyncApexJob = configurationSelectorInstance.asyncApexJobDetails(idOfCurrentBetch);
	    AsyncApexJob a=lstAsyncApexJob;
	    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	    String[] toAddresses;
	    /*if(test.isRunningTest())
        {
	    	toAddresses = new String[] {'abc@gmail.com'};
	    }
	    else
        {*/
			toAddresses = new String[] {a.CreatedBy.Email};	    
	    //}
	    mail.setToAddresses(toAddresses);
	    mail.setSubject('Classes Deletion Result');
		mail.setPlainTextBody(body);
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }		
}
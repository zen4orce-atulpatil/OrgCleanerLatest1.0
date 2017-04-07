global with sharing class CommentDependentClassBatch implements Database.Batchable<String>, Database.Stateful, Database.AllowsCallouts{
	
	public String typeName='';
	public List<String> lstPagesToComment;  
	public List<String> lstClassesToDelete=new List<String>();
	public String sessionId='';
    public List<String> lstFailedClasses=new List<String>();
    public map<String,List<String>> failedComponentsToComment=new map<String,List<String>>();

	global CommentDependentClassBatch(List<String> typeWiseMap,string sess)
	{
		sessionId = sess;
		lstPagesToComment=new List<String>();
		lstPagesToComment=typeWiseMap;
	}
	
	global List<String> start(Database.BatchableContext BC){
		
        return lstPagesToComment;	 
    }
    global void execute(Database.BatchableContext BC, List<String> scope){	
        try{
        	
        		for(String s:CommentDependents.CommentMultipleClasses(scope, sessionId))
        		{
        			lstFailedClasses.add(s);	
        		}
        		failedComponentsToComment.put('ApexClass',lstFailedClasses);
        } 
        catch(Exception e){
        	
        	System.debug('************class bacthc error****************'+e.getMessage() + e.getlinenumber());
        }
    }
    global void finish(Database.BatchableContext BC){
    	ConfigurationSelector configurationSelectorInstance = new ConfigurationSelector();
	    String body;
	    if(lstFailedClasses.size()>0){ 
	    	body='Class='+lstFailedClasses+' are not commented and will give errors while you compile. Please Comment these mannually';
	    }
	    else{
	    	body='All Classes are commented Successfully';
	    }
	    Id idOfCurrentBetch = BC.getJobId();
	    List<ApexClass> lstclasses=new List<ApexClass>();
	    AsyncApexJob lstAsyncApexJob = configurationSelectorInstance.asyncApexJobDetails(idOfCurrentBetch);
	    AsyncApexJob a=lstAsyncApexJob;
	    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	    String[] toAddresses;
	   /*if(test.isRunningTest()){
	    	toAddresses = new String[]{'abc@gmail.com'};
	    }else{*/
			toAddresses = new String[] {a.CreatedBy.Email};	    
	   // }
	    mail.setToAddresses(toAddresses);
	    mail.setSubject('Details of Classes Comment');
		mail.setPlainTextBody(body);
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }		
}
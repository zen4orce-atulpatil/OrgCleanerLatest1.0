global class CustomFieldBatchService implements Database.Batchable<String>,Database.AllowsCallouts,Database.Stateful {
    global Map<String,List<String>> mapList = new Map<String,List<String>>();
    global list<String> lstOfFields ;
    global Integer numberOfRecords = 0 ;
    public String sessionId;
    public List<List<String>> messages = new List<List<String>>() ;
    global CustomFieldBatchService(List<String> strList)
    {
        try
        {
            sessionId = UserInfo.getSessionId();
            lstOfFields = strList;
        }
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
        }
    } 
    
    //Start method of batch class
    global List<String> start(Database.BatchableContext BC)
    {
        try
        {
            return lstOfFields; //pass dynamic query to get the list of records
        }
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
            return null;
        }
    }
    
    //Execute method of batch class
    global void execute(Database.BatchableContext BC,List<String> lstOfFields)
    {
        try
        {
            MetadataAPI mapi = new MetadataAPI();
          if(lstOfFields.size() > 0)
            {
                messages.add(mapi.deleteField(lstOfFields,sessionId));
            }
        }
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
        }
       
    }
    
    //finish method of the batch class
    global void finish(Database.BatchableContext bc) 
    {
       try
        {
           ConfigurationSelector configurationSelectorInstance = new ConfigurationSelector();
            AsyncApexJob a = configurationSelectorInstance.asyncApexJobDetails(bc.getJobId());
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {a.CreatedBy.Email};
            mail.setToAddresses(toAddresses);
            mail.setSubject(Label.FailedDetails+ a.Status);
            mail.setPlainTextBody(Label.TotalJobItems + a.TotalJobItems +
           ' batches with '+ a.NumberOfErrors + 'failures.'+'\n'+Label.ReviewErrors+'\n'+messages);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        catch(Exception ex)
        {
            System.debug('ERROR:'+ex.getMessage());
        }
    }
}
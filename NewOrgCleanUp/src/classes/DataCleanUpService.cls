public with sharing class DataCleanUpService {
    
    public Set<String> dependentObjList{get;set;}
    public List<String> customObjList = new List<String>();
    public List<String> standardObjList = new List<String>();
    public String dependentString{get;set;}
    public String standardDataJson{get;set;}
    public String customDataJson{get;set;}
    public String objName{get;set;}
    public String ConfigurationList{get; set;}
    public String CurrentConfig {get; set;}
    public integer numberOfRecords{get;set;}
    public Boolean IsCustomData {get; set;}
    public Boolean IsStandardData {get; set;}
    public String ConfigName{get;set;}
    
    //Get all Details of front end 
    /*Description -- Get configName from UI and perform action based on it*/
    public void GetConfigDetails(){
        if(CurrentConfig == 'StandardData'){
            IsStandardData = true;
            getStandardData();
            standardDataJson = ConfigurationCleanUpServiceHandler.generateJsonForCustomData(standardObjList);
        }
        else if(CurrentConfig == 'CustomData'){
            IsCustomData = true;
            getCustomData();
            customDataJson = ConfigurationCleanUpServiceHandler.generateJsonForCustomData(customObjList);
        }
    }
    public DataCleanUpService()
    {
        
    }
    //Get standard Object list 
    public void getStandardData()
    {
        standardObjList = DataCleanUpServiceHandler.getStandardObjList();   
    }
    //Get custom Object list
   public void getCustomData()
   {
        customObjList = DataCleanUpServiceHandler.getCustomObjList();
   }
    //Find Dependency of objects 
   public void CleanConfigurations()
    {
        
        if(ConfigName == 'CustomData' || ConfigName == 'StandardData')
        {
            List<AsyncApexJob> apexJob = new List<AsyncApexJob>();
            apexJob = DataCleanUpSelector.batchRunningDetails('BatchApexForDeleteRecords');
            if(apexJob.size() == 0 )
            {
                List<String> selectedObjList = new List<String>();
                for(String details:ConfigurationList.split(','))
                {
                    selectedObjList.add(details.split('\\$')[1]);
                }
                dependentObjList = HierarchicalUtilityService.dependentObjects(selectedObjList);
                List<String> listToSet = New List<String>();
                listToSet.addAll(dependentObjList);
                if(listToSet.size() > 0)
                {
                   dependentString  = ConfigurationCleanUpServiceHandler.generateJsonForCustomData(listToSet);
                }
                else
                {
                    dependentString = ' Their is no dependency You can safely delete records';
                }
            }
            else
            {
                Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,''+Label.RecordsAreDeleting));
            }  
        }
    }
     public PageReference Dashboard(){
        return Page.OrgCleanerDashboard;
    }
    
    //This method is used to delete standard and custom object's records
    public void deleteData()
    {
        if(ConfigName == 'CustomData' || ConfigName == 'StandardData')
        {
            List<String> selectedCustomObjList = new List<String>();
            for(String details:ConfigurationList.split(','))
            {
                selectedCustomObjList.add(details.split('\\$')[1]);
            }
          DataCleanUpServiceHandler.deleteAllRecords(selectedCustomObjList);  
        }
    }
    //This method is used to see Number of Records on the object 
    public pageReference seeNumberOfRecords()
    {
       if(objName != null)
       {
         numberOfRecords = DataCleanUpSelector.numberOfReocrds(objName);
       }
        return null;
           
    }
}
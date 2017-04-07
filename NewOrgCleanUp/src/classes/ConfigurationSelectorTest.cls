@isTest
public with sharing class ConfigurationSelectorTest {
	//@isTest
	/*public static void testselectApexPages(){
		Configurationselector a = new Configurationselector();
		List<String> classesToSearch = new List<String>();
		classesToSearch.add('ClassOne');
		classesToSearch.add('ClassTwo');
		classesToSearch.add('ClassThree');
		List<String> lstPages = new List<String>();
		lstPages = a.selectApexPages(classesToSearch);
	}
    @isTest
    public static void testselectclasses(){
    	Configurationselector a = new Configurationselector();
		 String SearchQuery = 'FIND {ClassOne,ClassTwo}RETURNING ApexClass(Name)';
		a.selectclasses(SearchQuery);      
    }
    @isTest
    public static void testselectTriggers(){
    	Configurationselector a = new Configurationselector();
    	String SearchQuery = 'FIND {ClassOne,ClassTwo}RETURNING ApexTrigger(Name)';
		a.selectTriggers(SearchQuery);    
    }
    
    @isTest
    public static void testselectApexPagemarkup(){
    	Configurationselector a = new Configurationselector();
        String errmsg;
        String pageName ='SamplePage';
        ApexPage aa = a.selectApexPagemarkup('pageName'); 
        /*try{
        	   
        }catch(Exception e){
            errmsg=e.getMessage();
        }
        //System.assertEquals(true,errmsg.contains('List has no rows for assignment to SObject'));*/
    //}
    
   /* @isTest
    public static void testselectAllTriggers(){
    	Configurationselector a = new Configurationselector();
    	List<ApexTrigger> lstTriggers = new List<ApexTrigger>();
		lstTriggers = a.getTriggers();    
    }
   /* @isTest
    public static void testselectVisualforcePages(){
    	Configurationselector a = new Configurationselector();
        List<ApexPage> lstApexPages = new List<ApexPage>();
		lstApexPages = a.getVisualforcePages();
    }
   /* @isTest
    public static void testgetApexClasses(){
    	Configurationselector a = new Configurationselector();
    	List<ApexClass> lstClassesToDelete = new List<ApexClass>();
		lstClassesToDelete=a.getApexClasses();
    }
   /* @isTest
    public static void testSelectdgetApexClasses(){
    	Configurationselector a = new Configurationselector();
        List<String> lstclassesToSearch = new List<String>();
        lstclassesToSearch.add('ClassOne');
    	List<ApexClass> lstClassesToDelete = new List<ApexClass>();
		lstClassesToDelete=a.getApexClasses(lstclassesToSearch);
    }
   /* @isTest
    public static void testgetApexClassBody(){
        Configurationselector a = new Configurationselector();
        Map<ID, ApexClass> mapApexClass = new Map<ID, ApexClass>();
        String ClassName='SampleClass';
        mapApexClass = a.getApexClassBody(ClassName);
    }
   /* @isTest
    public static void testgetApexTrigger(){
    	Configurationselector a = new Configurationselector();
        Map<ID, ApexTrigger> mapApexTrigger = new Map<ID, ApexTrigger>();
        String triggerName = 'SampleTrigger';
        mapApexTrigger = a.getApexTrigger(triggerName);
    }*/
   // @isTest
   /* public static void testasyncApexJobDetails(){
    	Configurationselector a = new Configurationselector();
        
        Id jobId='7072800002nQFRDAA4';
        AsyncApexJob ap = a.asyncApexJobDetails(jobId); 
        try{
            
        	AsyncApexJob ap = Configurationcleanupselector.asyncApexJobDetails(jobId);    
        }catch(Exception e){
            String err=e.getMessage();
            System.assertEquals(true,err.contains('List has no rows for assignment to SObject'));
        }*/
    	
    //}
   // @isTest
    /*public static void testgetAllApexClasses(){
    	Configurationselector a = new Configurationselector();
        List<ApexClass> lstApexClasses = new List<ApexClass>(); 
        lstApexClasses = a.getAllApexClasses();
    }*/
   // @isTest
    /*public static void testgetAsyncApexJobStatus(){
    	Configurationselector a = new Configurationselector();
        List<AsyncApexJob> lstAsyncApexJob = new List<AsyncApexJob>();
        List<String> lstApexAsyncJobNames = new List<String>();
		lstApexAsyncJobNames.add('CommentDependentClass');
		lstApexAsyncJobNames.add('CommentDependentPages');
		lstApexAsyncJobNames.add('CommentDependentTriggers');
        try{
			lstAsyncApexJob =  a.getAsyncApexJobStatus(lstApexAsyncJobNames);            
        }catch(Exception e){
            String errmsg=e.getMessage();
            System.assertEquals(true,errmsg.contains('List has no rows for assignment to SObject'));
        }
    }*/
}
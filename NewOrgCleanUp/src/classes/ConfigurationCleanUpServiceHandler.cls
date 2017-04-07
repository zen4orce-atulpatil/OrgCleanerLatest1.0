/**
  * @Class Name: ConfigurationCleanUpServiceHandler
  * @Description: This is helper class for ConfigurationCleanUpService
  * ====================================================================================================================
  *   Version   | Date        | Author                  | Comments
  * --------------------------------------------------------------------------------------------------------------------
  *   1.0       |             | OrgCleaner Team         | 
  *   1.1       | 04/04/2017  | Amol Salve              | Code optimization
  * ====================================================================================================================
  **/
public class ConfigurationCleanUpServiceHandler {
    public static List<String> classesToDelete;
    public static map<Id,String> mapClassNameId;
    public static String sessionId;
    public final static string ID = 'id';
    public final static string NAME = 'name';
    public final static string ENBL = 'enbl';
    public final static string LEVEL = 'level';
    public final static string PARENT = 'parent';
    public final static string ISLEAF = 'isLeaf';
    public final static string EXPANDED = 'expanded';
    public final static string LOADED = 'loaded';
    public final static string ZERO = '0';
    public final static string ONE = '1';
    public final static string BLANK = '';
    public final static string FALSEVALUE = 'loaded'; 
    public final static string CONFIGID = 'configID';
    public final static string PARENTNAME = 'parentName';
    public final static string TRUEVALUE = 'true';
    public final static string DATA = 'data';
    public final static boolean BOOLEANTRUEVALUE = true;
    public final static boolean BOOLEANFALSEVALUE = false;
    public final static string SPACE = ' ';
    public final static string ORVALUE = 'OR ';
    public final static string NULLVALUE = 'null';
    public final static string FIND = 'FIND {';
    public final static string RETURNCLASSNAME = '}RETURNING ApexClass(Name)';
    public final static string RETURNTRIGGERNAME = '}RETURNING ApexTrigger(name)';
    public final static string UNDERSCORE = '_';
    public final static string ZERONSPACE = '0 ';
    public final static string QUESTIONMARK = ' ?';
    public final static string JOBNAME = 'Job-';
    public static string classNames;
    
   /**
     * @Author: Amol Salve
     * @Description: Used to generate json string for trigger
     * @Param: configurationMap ( Map of string Vs list of list of string )
     * @Return: string
     * @Date: 04/04/2017
     **/
    public static string generateJsonForTrigger(Map<string, List<List<string>>> configurationMap){
        
        JSONGenerator gen = JSON.createGenerator(BOOLEANTRUEVALUE);
        gen = createJsonObj(gen);
        Integer count = 1;  
		for(String objectName: configurationMap.keySet()){
        	
        	gen.writeStartObject();
        	gen.writeStringField(NAME, objectName);
            gen = creataParentJson(gen, count );
            gen.writeEndObject();
            Integer ChildCount = 0;
			for(List<String> configDetails : configurationMap.get(objectName)){
                
                gen.writeStartObject();
                gen.writeStringField(CONFIGID, configDetails[1]);
        		gen.writeStringField(NAME, configDetails[0]); 
                gen = creataChildJsonFromList(gen, ChildCount, count, objectName );
                gen.writeEndObject();
                ChildCount++;
            }
            count++;
        }
        gen.writeEndArray();
        gen.writeEndObject();
        return gen.getAsString();
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Used to generate json string for Apex pages
     * @Param: configurationMap ( list of ApexPages )
     * @Return: string
     * @Date: 04/04/2017
     **/
    public static string generateJsonForApexPage(List<ApexPage> configurationList){
        
        JSONGenerator gen = JSON.createGenerator(BOOLEANTRUEVALUE);
        gen = createJsonObj(gen);
        Integer count = 1;  
        for(ApexPage apexPageObj: configurationList){
            
            gen.writeStartObject();
            gen.writeStringField(CONFIGID, apexPageObj.ID);
            gen.writeStringField(NAME, apexPageObj.Name);
            gen = creataParentJson(gen, count );
            gen.writeEndObject();
            count++;
        }
        gen.writeEndArray();
        gen.writeEndObject();
        return gen.getAsString();
    }
     
   /**
     * @Author: Amol Salve
     * @Description: Used to generate json string for Apex class
     * @Param: configurationMap ( list of ApexClass )
     * @Return: string
     * @Date: 04/04/2017
     **/
    public static string generateJsonForApexClass(List<ApexClass> lstAllApexClasses){
        
        JSONGenerator gen = JSON.createGenerator(BOOLEANTRUEVALUE);
        gen = createJsonObj(gen);
        Integer count = 1;  
        for(ApexClass apexClassObj: lstAllAPexClasses){
            
            gen.writeStartObject();
            gen.writeStringField(CONFIGID, apexClassObj.ID);
            gen.writeStringField(NAME, apexClassObj.Name);
            gen = creataParentJson(gen, count );
            gen.writeEndObject();
            count++;
        }
        gen.writeEndArray();
        gen.writeEndObject();
        return gen.getAsString();
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Used to create string with all class name
     * @Param: classList ( list of string )
     * @Return: string
     * @Date: 04/04/2017
     **/
    public static string classNameString( list<string> classList ) {
     
    	string keywordsToSearch;
    	if( classList != null && classList.size() > 0 ) {
    		
    		for( string className : classList ) {
    		
    			keywordsToSearch=keywordsToSearch + className + SPACE +ORVALUE;	
    		}
    		keywordsToSearch = keywordsToSearch.removeStart(NULLVALUE);
    		keywordsToSearch = keywordsToSearch.removeEndIgnoreCase(ORVALUE);
    	}
    	return keywordsToSearch;
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Used to get all dependent classes
     * @Param: classList ( list of string )
     * @Return: list of string
     * @Date: 04/04/2017
     **/ 
    Public static List<String> SearchInClass(List<String> searchKeywords) {
     	
        ConfigurationSelector configurationSelectorInstance = new ConfigurationSelector();
        set<String> ClassSummary = new set<String>();
        List<String> listOfClasses = new List<String>();
        classNames = classNameString( searchKeywords );
        if( classNames != null && classNames.length() > 0 ){
    		
    		string SearchQuery = FIND + classNames + RETURNCLASSNAME;
    		List<Search.SearchResult> ClassSearchResult=configurationSelectorInstance.selectclasses(SearchQuery);
        	if(ClassSearchResult != null && ClassSearchResult.size() > 0){
            
    	    	for (Search.SearchResult searchResult : ClassSearchResult) { 
                
                	ApexClass Classes = (ApexClass) searchResult.getSObject(); 
                	ClassSummary.add(Classes.Name);
            	}
            	if( ClassSummary.size() > 0){
            
            		ClassSummary.removeAll(searchKeywords); 
        			listOfClasses.addAll(ClassSummary);
        		} 
        	}
        } 
        return listOfClasses; 
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Used to get all dependent trigger
     * @Param: classList ( list of string )
     * @Return: list of string
     * @Date: 04/04/2017
     **/
    Public static List<String> SearchInTrigger(List<String> searchKeywords) {   
        
        ConfigurationSelector configurationSelectorInstance = new ConfigurationSelector();
        String keywordsToSearch;
        String SearchQuery;
        List<String> TriggerSummary = new list<String>();
        if( classNames != null && classNames.length() > 0 ){
            
            SearchQuery = FIND + classNames + RETURNTRIGGERNAME;
            List<Search.SearchResult> TriggersearchResults=configurationSelectorInstance.selectTriggers(SearchQuery);        	
        	if(TriggersearchResults != null && TriggersearchResults.size() > 0){
            
            	for (Search.SearchResult TriggersResults : TriggersearchResults) { 
                	ApexTrigger Triggers = (ApexTrigger) TriggersResults.getSObject();
                	TriggerSummary.add(Triggers.Name);
            	}
         	}
         }
         return TriggerSummary;  
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Used to get all dependent ApexPages
     * @Param: classList ( list of string )
     * @Return: list of string
     * @Date: 04/04/2017
     **/
    Public static List<String> SearchInPage(List<String> searchKeywords){
    	
    	
    	ConfigurationSelector configurationSelectorInstance = new ConfigurationSelector();    
        List<String> PageNames = new List<String>();
        PageNames=configurationSelectorInstance.selectApexPages(searchKeywords);
        return PageNames;
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Used to generate JsonString 
     * @Param: lstComponents ( list of string )
     * @Return: string
     * @Date: 04/04/2017
     **/
    public static string generateJson(List<String> lstComponents){
        JSONGenerator gen = JSON.createGenerator(BOOLEANTRUEVALUE);
        gen = createJsonObj(gen);
        Integer count = 1;  
        for(String apexClassObj: lstComponents){
            gen.writeStartObject();
            gen.writeStringField(CONFIGID, BLANK);
    		gen.writeStringField(NAME, apexClassObj);
    		gen = creataParentJson(gen, count );
            gen.writeEndObject();
            count++;
        }
        gen.writeEndArray();
        gen.writeEndObject();
        return gen.getAsString();
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Used to delete classes
     * @Param: 1. mapClassNameandId ( mao of Id Vs string )
     *         2. lstDependentClasses ( list of string )
     *         3. lstDependentTriggers ( list of string )
     *         4. lstDependentPages ( list of string )
     * @Return: NA
     * @Date: 04/04/2017
     **/
    public static void deleteclasses(map<Id,String> mapClassNameandId,List<String> lstDependentClasses,List<String> lstDependentTriggers ,List<String> lstDependentPages) {
        
        mapClassNameId = new map<Id,String>(); 
        mapClassNameId.putAll(mapClassNameandId);
        classesToDelete=new List<String>();
        List<String> lstClassesToDelete = new List<String>();
        lstClassesToDelete.addAll(mapClassNameId.values());
        classesToDelete.addAll(lstClassesToDelete); 
        sessionId=UserInfo.getSessionId();
        Integer count = System.purgeOldAsyncJobs(Date.today()+1); 
        Database.executeBatch( new CommentDependentClassBatch( lstDependentClasses, sessionId ), 10 );
        Database.executeBatch( new CommentDependentTriggersBatch( lstDependentTriggers, sessionId ), 10 );
        Database.executeBatch( new CommentDependentPagesBatch( lstDependentPages, sessionId ), 10 );
        ScheduleDeletionBatch(); 
    }
    
        
   /**
     * @Author: Amol Salve
     * @Description: Used to schedule batch
     * @Param: NA
     * @Return: NA
     * @Date: 04/04/2017
     **/
    public static void ScheduleDeletionBatch(){
    	
    	Configurationselector configurationSelectorInstance = new Configurationselector();
        List<ApexClass> lstclasses = new List<ApexClass>(); 
        lstclasses = configurationSelectorInstance.getApexClasses( classesToDelete );
        DeleteclassesBatch deletionBatch = new DeleteclassesBatch( mapClassNameId, sessionId );
        BatchScheduler scheduler = new BatchScheduler();
        scheduler.batchClass = deletionBatch; 
        if( BatchScheduler.schedulestatus == BOOLEANFALSEVALUE || BatchScheduler.schedulestatus == null){

            string strJobName = JOBNAME + string.valueOf(system.now().second()) + UNDERSCORE + string.valueOf(system.now().minute()+1) + UNDERSCORE +
            					string.valueOf(system.now().hour()) + UNDERSCORE + string.valueOf(system.now().day()) + UNDERSCORE +
            					string.valueOf(system.now().month()) + UNDERSCORE + string.valueOf(system.now().year());
            string strSchedule = ZERONSPACE + string.valueOf(system.now().minute()+1) + SPACE + string.valueOf(system.now().hour()) + SPACE +
            					 string.valueOf(system.now().day()) + SPACE + string.valueOf(system.now().month()) + QUESTIONMARK +
            					 SPACE + string.valueOf(system.now().year());
            System.schedule(strJobName,strSchedule,scheduler);
        }
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Used to generator json for custom field
     * @Param: configurationList ( Map of string Vs list of string )
     * @Return: string
     * @Date: 04/04/2017
     **/
    public static string generateJsonForCustomField(Map<string, List<string>> configurationList){
      
    	JSONGenerator gen = JSON.createGenerator(BOOLEANTRUEVALUE);
        gen = createJsonObj(gen); 
        Integer count = 1;	
        
        for(String objectName: configurationList.keySet()){
         	
         	gen.writeStartObject();
         	gen.writeStringField(NAME, objectName);
         	gen = creataParentJson(gen, count );
            gen.writeEndObject();
            Integer ChildCount = 0;
            for(String configDetails : configurationList.get(objectName)) { 
                
                gen.writeStartObject();
                gen.writeStringField(CONFIGID, configDetails);
        		gen.writeStringField(NAME, configDetails);
        		gen = creataChildJsonFromList(gen, ChildCount, count, objectName );
        		gen.writeEndObject();
                ChildCount++;
            }
			count++;
        }
        gen.writeEndArray();
        gen.writeEndObject();
        return gen.getAsString();
    }

   /**
     * @Author: Amol Salve
     * @Description: Used to generator json for custom data
     * @Param: configurationList ( list of string )
     * @Return: string
     * @Date: 04/04/2017
     **/ 
    public static string generateJsonForCustomData(List<String> configurationList) {
   	
       JSONGenerator gen = JSON.createGenerator(BOOLEANTRUEVALUE);
       gen = createJsonObj(gen);
       Integer count = 1; 
       
       for(String objectName: configurationList){
           gen.writeStartObject();
           gen.writeStringField(NAME, objectName);
           gen = creataParentJson(gen, count );
           gen.writeEndObject();
           count++;
       }
       gen.writeEndArray();
       gen.writeEndObject();
       return gen.getAsString();
    }
  
   /**
     * @Author: Amol Salve
     * @Description: Used to generator JSONGenerator
     * @Param: 1. gen ( JSONGenerator )
     *         2. count ( Integer )
     * @Return: JSONGenerator
     * @Date: 04/04/2017
     **/
    public static JSONGenerator creataParentJson( JSONGenerator gen,  Integer count ){
    	
        gen.writeStringField(ID, String.valueOf(count));
        gen.writeStringField(ENBL, ZERO);
        gen.writeStringField(LEVEL, ZERO);
        gen.writeStringField(PARENT, BLANK);
        gen.writeStringField(ISLEAF, FALSEVALUE);
        gen.writeStringField(EXPANDED, FALSEVALUE);
        gen.writeStringField(LOADED, FALSEVALUE);
        return gen;
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Used to generator JSONGenerator
     * @Param: 1. gen ( JSONGenerator )
     *         2. childCount ( Integer )
     *         3. count ( Integer)
     *         4. objectName ( String )
     * @Return: JSONGenerator
     * @Date: 04/04/2017
     **/	
    public static JSONGenerator creataChildJsonFromList( JSONGenerator gen, Integer childCount, Integer count ,string objectName ){
    	    	
        gen.writeStringField(ID, count + BLANK + (childCount+1)); 
        gen.writeStringField(ENBL, ZERO);
        gen.writeStringField(LEVEL, ONE);
        gen.writeStringField(PARENTNAME, objectName);
        gen.writeStringField(PARENT, String.valueOf(count));
        gen.writeStringField(ISLEAF, TRUEVALUE);
        gen.writeStringField(EXPANDED, FALSEVALUE);
        gen.writeStringField(LOADED, FALSEVALUE);        
        return gen;
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Used to generator JSONGenerator
     * @Param: 1. gen ( JSONGenerator )
     * @Return: JSONGenerator
     * @Date: 04/04/2017
     **/
    public static JSONGenerator createJsonObj( JSONGenerator gen ){
    
       	gen.writeStartObject();
        gen.writeFieldName(DATA);
       	gen.writeStartArray();
    	return gen;
    }
}
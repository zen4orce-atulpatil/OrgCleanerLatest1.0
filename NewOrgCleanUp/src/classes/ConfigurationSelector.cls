/**
  * @Class Name: ConfigurationSelector
  * @Description: This is helper class for ConfigurationCleanUpService, used get Triggers, Classes, ApexPages From Org
  * ====================================================================================================================
  *   Version   | Date        | Author                  | Comments
  * --------------------------------------------------------------------------------------------------------------------
  *   1.0       |             | OrgCleaner Team         | 
  *   1.1       | 03/04/2017  | Amol Salve              | Code optimization
  * ====================================================================================================================
  **/
public class ConfigurationSelector {
    
    public map<string, ApexClass>    classNameVsClassMap;
    public map<string, ApexTrigger>  triggerNameVsTriggerMap;
    public map<string, ApexPage>     pageNameVsPageMap;
    public map<string, AsyncApexJob> classNameVsApexJobMap;
    public final string APEXCLASS = 'ApexClass';
    public final string APEXTRIGGER = 'ApexTrigger';
    public final string ASSIGNSIGN = '=';
    public final string LESSTHANSIGN = '>';
    public final string doubleInvertedComma = '"';
    
   /**
     * @Author: Amol Salve
     * @Description: Costructor
     * @Param: NA
     * @Return: NA
     * @Date: 03/04/2017
     **/
    public ConfigurationSelector() {
    	
    	pageNameVsPageMap = new map<string, ApexPage>();
    	classNameVsClassMap = new  map<string, ApexClass>();
    	classNameVsApexJobMap = new map<string, AsyncApexJob>();
    	triggerNameVsTriggerMap = new map<string, ApexTrigger>();  
    	for( AsyncApexJob apexJobObj : [ SELECT ApexClass.Name,
    											ApexClassID,
    											status
    									 FROM AsyncApexJob
    									 LIMIT 50000 ] ) {
    	
    		classNameVsApexJobMap.put( apexJobObj.ApexClass.Name, apexJobObj );								   
        } 
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Get all trigger record from org
     * @Param: NA
     * @Return: List of ApexTrigger
     * @Date: 03/04/2017
     **/ 
    public List<ApexTrigger> getTriggers() {
                
        list<ApexTrigger> apexTriggerList = new list<ApexTrigger>();
  		for( ApexTrigger triggerObj : [ SELECT TableEnumOrId,
  						                       Name 
  				 				    	FROM ApexTrigger
  				 						LIMIT 50000 ] ) {
  			
			apexTriggerList.add( triggerObj );
			triggerNameVsTriggerMap.put( triggerObj.Name, triggerObj );					 					
  	    } 
  	    return apexTriggerList;
    }
    
   /**
     * @Author: Amol Salve 
     * @Description: Get all visualforce page record from org
     * @Param: NA
     * @Return: List of ApexPage
     * @Date: 03/04/2017
     **/
    public List<ApexPage> getVisualforcePages() {      
                
        list<ApexPage> apexPageList = new list<ApexPage>();
  		for( ApexPage pageObj : [ SELECT Id,
  						                 Name,
  						                 Markup,
  						                 NamespacePrefix
  				 				  FROM ApexPage]){
  				 				  //WHERE NamespacePrefix != 'OrgCleaner' ] ) {
  			
			apexPageList.add( pageObj );
			pageNameVsPageMap.put( pageObj.Name, pageObj );				 					
  	    }
  	    return apexPageList;
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Get all apex classes record from org
     * @Param: NA
     * @Return: List of ApexClass
     * @Date: 03/04/2017
     **/
	public List<ApexClass> getApexClasses() {      
      		  	
  		list< ApexClass > apexClassList = new list< ApexClass >();
  		for( ApexClass classObj : [ SELECT Id,
  						                 Name,
  						                 NamespacePrefix 
  				 				    FROM ApexClass ]){
  				 				    //WHERE NamespacePrefix != 'OrgCleaner' ] ) {
  			
			apexClassList.add( classObj );
			classNameVsClassMap.put( classObj.Name, classObj );		 					
  	    }
  	    return apexClassList;
    }
    
   /**
     * @Author: Amol Salve
     * @Description: -
     * @Param: SearchQuery (string)
     * @Return: List of Search.SearchResult
     * @Date: 03/04/2017
     **/
	public List<Search.SearchResult> selectclasses( String SearchQuery ) {  
        system.debug('****************** sel SearchQuery******************'+SearchQuery);
        if( SearchQuery != null && SearchQuery.length() > 0 ){
            
            Search.SearchResults searchResults = Search.find( SearchQuery );
            return searchResults.get( APEXCLASS );
        }
        return null;
    } 
    
   /**
     * @Author: Amol Salve
     * @Description: -
     * @Param: SearchQuery (string)
     * @Return: List of Search.SearchResult
     * @Date: 03/04/2017
     **/
    public List<Search.SearchResult> selectTriggers( String SearchQuery ) {
        
        if( SearchQuery != null && SearchQuery.length() > 0 ) {
            
            Search.SearchResults searchResults = Search.find( SearchQuery );
            return searchResults.get( APEXTRIGGER );
        }
        return null;
    }
	
   /**
     * @Author: Amol Salve
     * @Description: -
     * @Param: searchKeywords ( List of string )
     * @Return: List of string
     * @Date: 03/04/2017
     **/
    public List<String> selectApexPages(List<String> searchKeywords){
    	
    	getVisualforcePages();
    	
    	Map<ID, ApexPage> pageMap = new Map<ID, ApexPage>();
    	
    	if( pageNameVsPageMap.keySet().size() > 0 ){
    		
    		for( string pageName : pageNameVsPageMap.keySet() ) {
    		
    			pageMap.put( pageNameVsPageMap.get( pageName ).Id, pageNameVsPageMap.get( pageName ) );
    		}
    	}
    	List<string> pageNameList = new List<String>();
    	if( searchKeywords != null && searchKeywords.size()>0){ 
    		
    		for( string searchKey :searchKeywords ) {
	        
	        	for( Id pageId : pageMap.keyset() ) {
	        	
	            	ApexPage apexObj = pageMap.get( pageId );	
            		string finalPageName = apexObj.Markup.normalizeSpace().substringAfter( ASSIGNSIGN ).substringBefore( LESSTHANSIGN );
	            	if( finalPageName == doubleInvertedComma + searchKey + doubleInvertedComma || finalPageName == searchKey ) {
	                
	                	pageNameList.add( apexObj.Name );
	            	}
	        	}
        	}
    	}
        return pageNameList;
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Used to fill Id Vs ApexClass Map
     * @Param: className ( String )
     * @Return: Map of Id Vs ApexClass
     * @Date: 03/04/2017
     **/
    public map<Id, ApexClass> getApexClassBody( String className ) {
    	
    	map<Id, ApexClass> apexClassMap = new map<Id, ApexClass>();
    	if( className != null && className.length() > 0 ) {
    		
    		if( classNameVsClassMap.containsKey( className ) ) {
    			
				apexClassMap.put( classNameVsClassMap.get( className ).Id, classNameVsClassMap.get( className ) );    		
    		}
    	}
    	return apexClassMap;
  	}
  	
   /**
     * @Author: Amol Salve
     * @Description: Used to fill Id Vs ApexTrigger Map
     * @Param: triggerName ( String )
     * @Return: Map of Id Vs ApexTrigger
     * @Date: 03/04/2017
     **/
    public map<Id, ApexTrigger> getApexTrigger( String triggerName ) {
   		
   		map<Id, ApexTrigger> apexTriggerMap = new map<Id, ApexTrigger>();
   		if( triggerName != null && triggerName.length() > 0 ) {
   			
   			if( triggerNameVsTriggerMap.containsKey( triggerName ) ) {
    			
				apexTriggerMap.put( triggerNameVsTriggerMap.get( triggerName ).Id, triggerNameVsTriggerMap.get( triggerName ) );
    		}	
   		}
    	
    	return apexTriggerMap;	
    }
   
   /**
     * @Author: Amol Salve
     * @Description: Get ApexPage record.
     * @Param: pageName ( String )
     * @Return: Map of Id Vs ApexTrigger
     * @Date: 03/04/2017
     **/ 
    public ApexPage selectApexPagemarkup( string pageName ) {
    	
    	getVisualforcePages();
    	getTriggers();
    	if( pageName != null && pageName.length() > 0 ) { 
    		
    		if( pageNameVsPageMap.containsKey( pageName ) ) {
    		    	
				ApexPage apexPageBody = pageNameVsPageMap.get( pageName );
				
				return apexPageBody;    		
			}
    	}
    	return null;
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Get AsyncApexJob record.
     * @Param: jobId ( Id )
     * @Return: AsyncApexJob record
     * @Date: 03/04/2017
     **/
    public AsyncApexJob asyncApexJobDetails( Id jobId ) {
        
        AsyncApexJob jobObj;
        try {
        	
        	if( jobId != null ) {
                
                jobObj = [ SELECT Id, 
                				  Status, 
                				  NumberOfErrors, 
                				  JobItemsProcessed,
                                  TotalJobItems, 
                                  CreatedBy.Email
                           FROM AsyncApexJob 
                           WHERE Id =:jobId LIMIT 1 ];
            }
        	return jobObj;
        } catch( Exception ex ) {
           
   			return new AsyncApexJob();
        }
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Get apexClass record.
     * @Param: ListOfClassName ( List of string )
     * @Return: List of ApexClass record
     * @Date: 03/04/2017
     **/
    public List<ApexClass> getApexClasses(List<String> listOfClassName) {
    	
    	list<ApexClass> apexClassList = new list<ApexClass>();
    	if( listOfClassName != null && listOfClassName.size() > 0 ){
    		
    		for( string className : listOfClassName ) {
    		
    			if( classNameVsClassMap.containsKey( className ) ) {
    			
    				apexClassList.add( classNameVsClassMap.get( className ) );
    			}    		
    		}
    	}
    	return apexClassList;
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Get list of AsyncApexJob record.
     * @Param: ListOfClassName ( List of string )
     * @Return: ListOfClassName ( List of string )
     * @Date: 03/04/2017
     **/
	public list<AsyncApexJob> getAsyncApexJobStatus( list<String> apexJobclassNameList ) {
  		
  		list<AsyncApexJob> apexJobList = new list<AsyncApexJob>();
  		if( apexJobclassNameList != null && apexJobclassNameList.size() > 0 ){
  			
  			for( string className : apexJobclassNameList ) {
  		
  				if( classNameVsApexJobMap.containsKey( className ) ) {
  			
  					apexJobList.add( classNameVsApexJobMap.get( className ) );
  				}
  			}
  		}
  		return apexJobList;
  	}
  	
   /**
     * @Author: Amol Salve
     * @Description: Get NamespacePrefix of Organization.
     * @Param: NA
     * @Return: NA
     * @Date: 03/04/2017
     **/ 
    public string nameSpaceprefixOfOrg() {
        
        String nameSpace;
        Organization org = [ SELECT NamespacePrefix 
        					 FROM Organization
        					 LIMIT 50000 ];
        nameSpace = String.valueOf(org.NamespacePrefix);
        return nameSpace;
    }
}
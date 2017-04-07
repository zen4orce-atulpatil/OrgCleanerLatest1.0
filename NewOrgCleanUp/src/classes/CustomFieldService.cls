/**
  * @Class Name: CustomFieldService
  * @Description: This is helper class for ConfigurationCleanUpService
  * ====================================================================================================================
  *   Version   | Date        | Author                  | Comments
  * --------------------------------------------------------------------------------------------------------------------
  *   1.0       |             | OrgCleaner Team         | 
  *   1.1       | 07/04/2017  | Amol Salve              | Code optimization
  * ====================================================================================================================
  **/
public class CustomFieldService {
	
   /**
     * @Author: Amol Salve
     * @Description: Get all object list form org
     * @Param: NA
     * @Return: List of string
     * @Date: 07/04/2017
     **/
    public static List<String> listOfAllObj() {
       
		list<String> listOfAllObject = new list<String>();
		list<String> listOfStandardObject = new list<string>();
		list<String> listOfCustomObject = new list<string>();
       	list<String> listOfObject = ConfigurationCleanUpUtility.allObjects();
       	if( listOfObject != null && listOfObject.size() > 0 ) {
       	
       		listOfStandardObject = ConfigurationCleanUpUtility.allStandardObj( listOfObject );
       		listOfCustomObject = ConfigurationCleanUpUtility.allCustomObj( listOfObject );
       	} 
        if( listOfStandardObject.size() > 0  ){
        	
        	listOfAllObject.addAll( listOfStandardObject );
        }         
       	if( listOfCustomObject.size() > 0  ){
        	
        	listOfAllObject.addAll( listOfCustomObject );
        }            
       	return listOfAllObject;
   }
   
   /**
     * @Author: Amol Salve
     * @Description: Get all map with key as object name vs list of fields
     * @Param: NA
     * @Return: Map with key as object name vs list of fields
     * @Date: 07/04/2017
     **/ 
   public static Map<String,List<String>> listOfAllFields() {
   	
       map<string, list<string>> customFieldsMap = new map<string, list<string>>();
       list<string> listOfAllObject = listOfAllObj();
              
       if( listOfAllObject != null && listOfAllObject.size() > 0 ) {
       	
	       for( string obj : listOfAllObject) {
	       	 
	           List<String> lstOfFields = allFieldsOfObject( obj ); 
	           if( lstOfFields != null && lstOfFields.size() > 0 ) {
	           	
	           		customFieldsMap.put( obj, lstOfFields );
	           }
	       }
       }
       return customFieldsMap;
   }
 
   /**
     * @Author: Amol Salve
     * @Description: Get all custom fields for object 
     * @Param: objName( string )
     * @Return: List of all custom fields for object
     * @Date: 07/04/2017
     **/
   public static list<String> allFieldsOfObject( string objName ) {
		
		list<String> fieldList = new list<String>();
		if( objName != null && objName.length() > 0 ) { 
			
		    map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
		    if( schemaMap != null && schemaMap.keySet().size() > 0 ) {
				        
		    	map <String,Schema.SObjectField> fieldMap = schemaMap.get( objName ).getDescribe().fields.getMap();
		   		if( fieldMap != null && fieldMap.keyset().size() > 0 ) {
		   		
		   			for( Schema.SObjectField objField : fieldMap.Values() ) {
		   
		        		schema.describefieldresult detailOfField = objField.getDescribe();
		        		if( detailOfField.isCustom() ) {
		        	 
		            		fieldList.add( detailOfField.getName() );
		        		}
		    		}
		   		}		   		        
		    }
		}      
       return fieldList;    
	}
  
   /**
     * @Author: Amol Salve
     * @Description: Used to delete custom field 
     * @Param: listOfField ( list of string )
     * @Return: NA
     * @Date: 07/04/2017
     **/
    public static void deleteFields( List<String> listOfField ) {
   	 
       CustomFieldBatchService batchInstance = new CustomFieldBatchService( listOfField ) ; 
       database.executeBatch( batchInstance, 10 );
    }
}
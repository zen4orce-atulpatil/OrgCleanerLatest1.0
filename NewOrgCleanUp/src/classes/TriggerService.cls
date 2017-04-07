/**
  * @Class Name: ConfigurationSelector_Amol
  * @Description: This is helper class for ConfigurationCleanUpService
  * ====================================================================================================================
  *   Version   | Date        | Author                  | Comments
  * --------------------------------------------------------------------------------------------------------------------
  *   1.0       |             | OrgCleaner Team         | 
  *   1.1       | 04/04/2017  | Amol Salve              | Code optimization
  * ====================================================================================================================
  **/
public class TriggerService {
	
	public static final string APEXTRIGGER = 'ApexTrigger';
    /**
     * @Author: Amol Salve
     * @Description: Used to fill and return map of string Vs list of list of string
     * @Param: NA
     * @Return: Map of string Vs list of list of string
     * @Date: 04/04/2017
     **/
    public static map<string, list<List<String>>> getTriggers(){
    		
    	ConfigurationSelector configurationSelectorInstance = new ConfigurationSelector();
        list<ApexTrigger> triggerList = configurationSelectorInstance.getTriggers();
        map<string, list<list<string>>> triggerMap = new map<string, list<list<String>>>();
        if( triggerList != null && triggerList.size() > 0 ) {
        
        	for( ApexTrigger apexTriggerObj : triggerList ) {
        	 
            	if( triggerMap.containsKey( apexTriggerObj.TableEnumOrId ) ) {
            		
            		triggerMap.get( apexTriggerObj.TableEnumOrId ).add( new list<string> { apexTriggerObj.Name, apexTriggerObj.ID } );
       			}
            	else{
               
                	triggerMap.put( apexTriggerObj.TableEnumOrId, new list<list<string>> { new list<string> { apexTriggerObj.Name, apexTriggerObj.ID } } );
            	}
        	}
        }
        return triggerMap; 
    } 
    
   /**
     * @Author: Amol Salve
     * @Description: Used to execute ConfigurationCleanUpBatchService batch to delete selected trigger
     * @Param: selectedTriggerList ( List of string)
     * @Return: NA
     * @Date: 04/04/2017
     **/ 
    public static void deleteTrigger( list<string> selectedTriggerList ){   
      	
      	if( selectedTriggerList != null && selectedTriggerList.size() > 0 ) {
      		
        	database.executeBatch(new ConfigurationCleanUpBatchService( new map<string, list<String>> { APEXTRIGGER => new list<string> ( selectedTriggerList ) } ),100);
      	}      	
    }
}
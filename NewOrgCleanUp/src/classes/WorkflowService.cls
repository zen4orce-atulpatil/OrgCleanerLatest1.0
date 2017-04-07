/**
  * @Class Name: WorkflowService
  * @Description: This is helper class for ConfigurationCleanUpService
  * ====================================================================================================================
  *   Version   | Date        | Author                  | Comments
  * --------------------------------------------------------------------------------------------------------------------
  *   1.0       |             | OrgCleaner Team         | 
  *   1.1       | 07/04/2017  | Amol Salve              | Code optimization
  * ====================================================================================================================
  **/
public class WorkflowService {
	
	public final static string BLANK = '';
    public final static string DOT = '.';
    public final static string WORKFLOW = 'Workflow';
    public final static string VALIDATIONRULE = 'ValidationRule';

   /**
     * @Author: Amol Salve
     * @Description: Used to fill map with key as object name and value as list of list of workflow namea and id of
     *				 MetadataService.FileProperties
     * @Param: NA
     * @Return: Map of string Vs list of list of string
     * @Date: 07/04/2017
     **/
    public static Map<string, List<List<String>>> getMetadataFor( string metadataName ) {
   
        Map<string, List<List<String>>> WorkflowMap = new Map<string, List<List<String>>>();
        MetadataAPI metadataApiObj = new MetadataAPI();
        MetadataService.FileProperties[] filePropertyList;
        if ( metadataName == WORKFLOW ) {
        	 
        	filePropertyList = metadataApiObj.listWorkflowMetadata();
        }
        else if( metadataName == VALIDATIONRULE ) {
        	
        	filePropertyList = metadataApiObj.listValidationRuleMetadata();
        }
        if( filePropertyList != null && filePropertyList.size() > 0 ) {
            
            for( MetadataService.FileProperties fileProperty : filePropertyList ) {
            	
                if( fileProperty.fullName != null && fileProperty.fullName != BLANK ) {
                    
                    if( WorkflowMap.containsKey( fileProperty.fullName.substringBefore( DOT ) ) ) { 
      
                        WorkflowMap.get( fileProperty.fullName.substringBefore( DOT ) ).add( new list<string>{ fileProperty.fullName.substringAfter( DOT ),
                        																					   fileProperty.Id } );
                    }
                    else{
                        
                        WorkflowMap.put( fileProperty.fullName.substringBefore( DOT ), new list<list<string>>{ new list<string> { fileProperty.fullName.substringAfter( DOT ),
                        																								    fileProperty.ID } } );
                    } 
                }
            }
        }
        return WorkflowMap;        
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Used to delete workflow from org
     * @Param: selectedWorkflows ( List of string ( object name + workflow name ) )
     * @Return: NA
     * @Date: 07/04/2017
     **/
    public static void deleteWorkflows( List<String> listOfWorkflow ) {   
        
        Map<string, List<String>> workflowsMap = new Map<string, List<String>>();
        workflowsMap.put( WORKFLOW, listOfWorkflow );
        database.executeBatch( new ConfigurationCleanUpBatchService( workflowsMap ), 100 );
    }
    
   /**
     * @Author: Amol Salve
     * @Description: Used to delete validation rule from org
     * @Param: selectedWorkflows ( List of string ( object name + validation rule name ) )
     * @Return: NA
     * @Date: 07/04/2017
     **/
    public static void deleteValidationRules( List<String> listOfValidationRule ) {
    	
        Map<string, List<String>> validationRulesMap = new Map<string, List<String>>();
        validationRulesMap.put( VALIDATIONRULE, listOfValidationRule );
        database.executeBatch(new ConfigurationCleanUpBatchService(validationRulesMap),100);        
    }
}
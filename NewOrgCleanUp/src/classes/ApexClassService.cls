/**
  * @Class Name: ApexClassService
  * @Description: This is helper class for ConfigurationCleanUpService
  * ====================================================================================================================
  *   Version   | Date        | Author                  | Comments
  * --------------------------------------------------------------------------------------------------------------------
  *   1.0       |             | OrgCleaner Team         | 
  *   1.1       | 07/04/2017  | Amol Salve              | Code optimization
  * ====================================================================================================================
  **/
public class ApexClassService {
	
   /**
     * @Author: Amol Salve
     * @Description: Used to get all class form org
     * @Param: NA
     * @Return: list of apex class
     * @Date: 07/04/2017
     **/
	public static List<ApexClass> getClasses() {
		
		ConfigurationSelector configurationSelectorInstance = new ConfigurationSelector();
		return configurationSelectorInstance.getApexClasses();	
	}  
	
   /**
     * @Author: Amol Salve
     * @Description: Used to get all dependent class for selected apexclass
     * @Param: classList (list of string ( ClassName ) )
     * @Return: list of string( all dependend class name )
     * @Date: 07/04/2017
     **/
	public static List<String> getDependentClasses(List<String> classList) {
		
		return ConfigurationCleanUpServiceHandler.SearchInClass( classList );
	}
	
   /**
     * @Author: Amol Salve
     * @Description: Used to get all dependent pages for selected apexclass
     * @Param: classList (list of string ( ClassName ) )
     * @Return: list of string( all dependend page name )
     * @Date: 07/04/2017
     **/
	public static List<String> getDependentPages( List<String> classList ) {
		
		return ConfigurationCleanUpServiceHandler.SearchInPage( classList );
	}
	
   /**
     * @Author: Amol Salve
     * @Description: Used to get all dependent trigger for selected apexclass
     * @Param: classList (list of string ( ClassName ) )
     * @Return: list of string( all dependend trigger name )
     * @Date: 07/04/2017
     **/
	public static List<String> getDependentTriggers( List<String> classList ){
		
		return ConfigurationCleanUpServiceHandler.SearchInTrigger( classList );
	}
	
   /**
     * @Author: Amol Salve
     * @Description: Used to delete class 
     * @Param: 1. mapOfIdVsClassName ( map of id Vs className )
     *		   2. listOfDependentClass ( list of dependend class name )
     *         3. listOfDependentTrigger ( list of dependent trigger name )
     *         4. listOfDependentPages ( list of dependent page name )
     * @Return: NA
     * @Date: 07/04/2017
     **/
	public static void deleteclasses( map<Id,String> mapOfIdVsClassName, List<String> listOfDependentClass, List<String> listOfDependentTrigger, List<String> listOfDependentPages ) {
    	
    	ConfigurationCleanUpServiceHandler.deleteclasses( mapOfIdVsClassName, listOfDependentClass, listOfDependentTrigger, listOfDependentPages );
    }
}
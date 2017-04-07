public with sharing class ApexClassService {
	public static List<ApexClass> getClasses(){
		ConfigurationSelector configurationSelectorInstance = new ConfigurationSelector();
		return configurationSelectorInstance.getApexClasses();	
	}  
	
	public static List<String> getDependentClasses(List<String> selectedClasses){
		return ConfigurationCleanUpServiceHandler.SearchInClass(selectedClasses);
	}
	
	public static List<String> getDependentPages(List<String> selectedClasses){
		
		return ConfigurationCleanUpServiceHandler.SearchInPage(selectedClasses);
	}
	
	public static List<String> getDependentTriggers(List<String> selectedClasses){
		return ConfigurationCleanUpServiceHandler.SearchInTrigger(selectedClasses);
	}
	public static void deleteclasses(map<Id,String> mapClassNameandId,List<String> lstDependentClasses,List<String> lstDependentTriggers,List<String> lstDependentPages){
    	ConfigurationCleanUpServiceHandler.deleteclasses(mapClassNameandId,lstDependentClasses,lstDependentTriggers,lstDependentPages);
    }
}
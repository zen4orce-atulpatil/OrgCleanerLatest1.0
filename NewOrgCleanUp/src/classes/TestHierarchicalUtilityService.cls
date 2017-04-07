@isTest
public with sharing class TestHierarchicalUtilityService {
    static TestMethod void TestallObjects()
    {
    	 List<String> lstOfObj = HierarchicalUtilityService.allObjects();
    	 System.assertEquals(true,lstOfObj.size() != 0);
    }
    static TestMethod void TestAllStandardObj()
    {
    	List<String> lstOfObj = new List<String>();
    	lstOfObj.add('Account');
    	lstOfObj.add('Contact');
    	lstOfObj.add('Case');
    	List<String> lstOfObjStd  = HierarchicalUtilityService.allStandardObj(lstOfObj);
    	System.assertEquals(true,lstOfObjStd.size() != 0);
    }
    static TestMethod void TestAllCustomObj()
    {
    	List<String> lstOfObj = new List<String>();
    	lstOfObj.add('Account');
    	lstOfObj.add('Contact');
    	lstOfObj.add('Case');
    	List<String> lstOfObjCus  = HierarchicalUtilityService.allCustomObj(lstOfObj);	
    }
    static TestMethod void TestfindChildObjects()
    {
    	List<String> lstOfObj = new List<String>();
    	lstOfObj.add('Account');
    	lstOfObj.add('Contact');
    	lstOfObj.add('Case');
    	Map<string,Set<String>> mapList = HierarchicalUtilityService.findChildObjects(lstOfObj);
    	List<String> lstOfValues  = HierarchicalUtilityService.findNullValues(mapList);
   		System.assertEquals(true,lstOfValues.size() != 0);
    }
    static TestMethod void TestdependentObjects()
    {
    	List<String> lstOfObj = new List<String>();
    	lstOfObj.add('Account');
        Set<String> lstOfValues = HierarchicalUtilityService.dependentObjects(lstOfObj);
   		System.assertEquals(true,lstOfValues.size() != 0);
    }
}
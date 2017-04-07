@isTest
public with sharing class TestDataCleanUpService {
	
	static testMethod void TestGetConfigDetailsOfStandard()
	{
		DataCleanUpService ds = new DataCleanUpService();
		ds.CurrentConfig = 'StandardData';
		ds.GetConfigDetails();
		System.assertEquals(true,ds.standardDataJson != null);
	}
    static testMethod void TestGetConfigDetailsOfCustom()
	{
		DataCleanUpService ds = new DataCleanUpService();
		ds.CurrentConfig = 'CustomData';
		ds.GetConfigDetails();
		//System.assertEquals(true,ds.standardDataJson != null);
	}
    static TestMethod void TestCleanConfigurations()
    {
		DataCleanUpService ds = new DataCleanUpService();
        ds.ConfigName = 'StandardData';
        ds.ConfigurationList = 'Account'+'$'+'Contact';
        ds.CleanConfigurations();
   	}
    static TestMethod void TestdeleteData()
    {
    	DataCleanUpService ds = new DataCleanUpService();
    	ds.ConfigName = 'StandardData';
    	ds.ConfigurationList = 'Account'+'$'+'Contact';
    	ds.deleteData();
    }
    static TestMethod void TestSeeNumberOfRecords()
    {
    	DataCleanUpService ds = new DataCleanUpService();
    	ds.objName = 'Account';
    	ds.seeNumberOfRecords();
    }
    
}
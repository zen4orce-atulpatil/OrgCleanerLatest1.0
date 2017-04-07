@isTest
public with sharing class TestBatchApexDeleteRecordsService {
	
	private  static testMethod void testBatch()
	{
      list<String> strList = new List<String>();
      strList.add('Account');
      Account a = new Account();
      a.Name = 'XYZ';
      insert a;
      strList.add('Case');
      BatchApexDeleteRecordsService d = new BatchApexDeleteRecordsService(strList.get(0),strList);
      Test.startTest();
      database.executeBatch(d,2000);
      Test.stopTest();
      
	}
}
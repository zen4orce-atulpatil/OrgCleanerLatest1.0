@isTest
public with sharing class TestDataCleanUpDomain {
	public static testMethod void TestExecuteMethod()
    {
        Account a = new Account();
        a.Name = 'OrgCleaner';
        insert a;
        Account a1 = new Account();
        a1.Name = 'OrgCleanerTwo';
        insert a1;
        List<Account> actList = [SELECT id FROM Account];
        DataCleanUpDomain.executeMethod(actList);
        List<Account> actList1 = new List<Account>();
        actList1 = [SELECT id FROM Account];
        System.assertEquals(0,actList1.size());
    }
    
}
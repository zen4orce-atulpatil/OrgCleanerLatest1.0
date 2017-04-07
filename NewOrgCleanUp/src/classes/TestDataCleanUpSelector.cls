@isTest
public class TestDataCleanUpSelector {
    public static testMethod void testNameSpaceprefixOfOrg()
    {
        String nameSpace;
        Organization org = [SELECT NamespacePrefix FROM Organization];
        nameSpace = String.valueOf(org.NamespacePrefix);
        String currentNameSpace =  DataCleanUpSelector.nameSpaceprefixOfOrg();
        System.assertEquals(nameSpace,currentNameSpace);
        
    }
    public static testMethod void TestbatchRunningDetails()
    {
        String nameSpace;
        Organization org = [SELECT NamespacePrefix FROM Organization];
        nameSpace = String.valueOf(org.NamespacePrefix);
        String currentNameSpace =  DataCleanUpSelector.nameSpaceprefixOfOrg();
        System.assertEquals(nameSpace,currentNameSpace);
        
    }
    public static testMethod void TestNumberOfReocrds()
    {
        Account a = new Account();
        a.Name = 'OrgCleaner';
        insert a;
        integer count = DataCleanUpSelector.numberOfReocrds('Account');
        System.assertEquals(1,count );
    }

}
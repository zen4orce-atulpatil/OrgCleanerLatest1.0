@isTest
public with sharing class CommentDependentClassBatchTest {
    public static testmethod void testCommentDependentClassBatch(){
    	List<String> lstClassesTo = new List<String>();
    	lstClassesTo.add('SampleClass'); 
        Test.startTest();
    	Database.executeBatch(new CommentDependentClassBatch(lstClassesTo,UserInfo.getSessionId()));
        Test.stopTest();
    }
}
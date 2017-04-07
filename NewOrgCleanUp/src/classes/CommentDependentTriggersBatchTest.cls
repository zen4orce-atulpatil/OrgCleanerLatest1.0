@isTest
public with sharing class CommentDependentTriggersBatchTest {
    public static testmethod void testCommentDependentTriggersBatchTest(){
    	List<String> lstTriggersTo = new List<String>();
    	lstTriggersTo.add('SampleTrigger'); 
        Test.startTest();
    	Database.executeBatch(new CommentDependentTriggersBatch(lstTriggersTo,UserInfo.getSessionId()));
        Test.stopTest();
    } 
}
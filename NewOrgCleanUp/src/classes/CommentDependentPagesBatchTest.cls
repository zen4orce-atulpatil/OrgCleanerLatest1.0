@isTest
public with sharing class CommentDependentPagesBatchTest {
    public static testmethod void testCommentDependentPagesBatchTest(){
    	List<String> lstPagesTo = new List<String>();
    	lstPagesTo.add('SamplePage'); 
        Test.startTest();
    	Database.executeBatch(new CommentDependentPagesBatch(lstPagesTo,UserInfo.getSessionId()));
        Test.stopTest();
    }
}
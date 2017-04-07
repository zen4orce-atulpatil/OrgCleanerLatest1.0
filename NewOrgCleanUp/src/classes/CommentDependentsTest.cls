@isTest
public with sharing class CommentDependentsTest {
    public static testmethod void testCommentMultipleClasses(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        List<String> lstCLasses = new List<String>();
    	lstCLasses.add('ClassOne');
    	lstCLasses.add('ClassTwo');
        String containerName='abc';
        List<String> failedclasses=new List<String>();
        failedclasses = CommentDependents.CommentMultipleClasses(lstCLasses, UserInfo.getSessionId());
        
        // Verify response received contains fake values
       /* String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"foo":"bar"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());*/
    }
    public static testmethod void testCommentMultipleTrigger(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        // Call method to test.
        // This causes a fake response to be sent
        List<String> lstTriggers = new List<String>();
    	lstTriggers.add('TriggerOne');
    	lstTriggers.add('TriggerTwo');
        List<String> failedclasses=new List<String>();
        failedclasses = CommentDependents.CommentMultipleTriggers(lstTriggers, UserInfo.getSessionId());
        
        // Verify response received contains fake values
       /* String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"foo":"bar"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());*/
    }
    public static testmethod void testCommentMultiplePage(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        // Call method to test.
        // This causes a fake response to be sent
        List<String> lstPages = new List<String>();
    	lstPages.add('PageOne');
    	lstPages.add('PageTwo');
        List<String> failedclasses=new List<String>();
        failedclasses = CommentDependents.CommentMultiplePages(lstPages, UserInfo.getSessionId());
        
        // Verify response received contains fake values
       /* String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"foo":"bar"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());*/
    }
    public static testmethod void testpollcurrentTrigger(){
    	Test.setMock(HttpCalloutMock.class, new MockHttpResponseforTrigger());
    	CommentDependents.pollcurrentTrigger(UserInfo.getSessionId());	
    }
    public static testmethod void testpollcurrentApexPage(){
    	Test.setMock(HttpCalloutMock.class, new MockHttpResponseforApexPage());
    	CommentDependents.pollcurrentApexPage(UserInfo.getSessionId());
    }
    public static testmethod void testpollCurrentClass(){
    	Test.setMock(HttpCalloutMock.class, new MockHttpResponseforApexClass());
    	CommentDependents.pollCurrentClass(UserInfo.getSessionId());
    }
    
    public static testmethod void testcreateMetadataContainer(){
    	Test.setMock(HttpCalloutMock.class, new MockHttpResponseforMetadataContainer());
    	CommentDependents.createMetadataContainer('Sample',UserInfo.getSessionId());
    }
}
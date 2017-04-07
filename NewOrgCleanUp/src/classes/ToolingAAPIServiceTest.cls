@isTest
public with sharing class ToolingAAPIServiceTest {
    public static testmethod void testTriggerDelete(){
    	ToolingAPIService t = new ToolingAPIService();
    	Id triggerId = '01q28000000kJuS';
    	Test.setMock(HttpCalloutMock.class, new HttpResponseTriggerToolingAPIService());
    	t.TriggerDelete(triggerId,UserInfo.getSessionId());
    }
    public static testmethod void testClassDelete(){
    	ToolingAPIService t = new ToolingAPIService();
    	Test.setMock(HttpCalloutMock.class, new HttpResponseClassToolingAPIService());
    	Id triggerId = '01q28000000kJuS';
    	t.ClassDelete(triggerId,UserInfo.getSessionId());
    }
    public static testmethod void testPageDelete(){
    	ToolingAPIService t = new ToolingAPIService();
    	Test.setMock(HttpCalloutMock.class, new HttpResponsePageToolingAPIService());
    	Id triggerId = '01q28000000kJuS';
    	t.PageDelete(triggerId,UserInfo.getSessionId());
    }
}
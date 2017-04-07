@isTest
public with sharing class ApexPageServiceTest {
    @isTest
    public static void testgetApexPages(){
    	List<ApexPage> lstApexPages = new List<ApexPage>();
    	lstApexPages = ApexPageService.getApexPages();
    }
    @isTest
    public static void testdeleteApexPages(){
    	List<String> selectedApexPages = new List<String>();
    	selectedApexPages.add('SamplPage');
    	ApexPageService.deleteApexPages(selectedApexPages);
    }
}
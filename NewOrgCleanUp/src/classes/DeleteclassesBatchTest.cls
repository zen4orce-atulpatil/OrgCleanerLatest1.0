@isTest
public with sharing class DeleteclassesBatchTest {
    public static testmethod void testDeleteclassesBatch(){
    	 map<Id,String> mapIdName = new map<Id,String>();
    	 Id ClassId = '01q28000000kJuS';
    	 mapIdName.put(ClassId,'SamplClass');
    	 Test.startTest();
    	 Database.executeBatch(new DeleteclassesBatch(mapIdName,UserInfo.getSessionId()));
    	 Test.stopTest(); 
    }
    
}
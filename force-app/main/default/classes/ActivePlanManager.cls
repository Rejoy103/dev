@RestResource(urlMapping='/addplan/*')
global with sharing class ActivePlanManager {
	@HttpPost
    global static Id createActivePlan(String c,Integer dp){
        Plan_Customer__c customer=[Select Id,Name,HasActivePlan__c FROM Plan_Customer__c WHERE Name=:c];
        List<Data_Plan__c> dpp=[SELECT Id,Name From Data_Plan__c];
        Active_Plan__c ap=new Active_Plan__c();
        if(customer.HasActivePlan__c){
            return null;
        }else{
            ap.Customer__c=customer.Id;
            ap.Data_Plan__c=dpp.get(dp).Id;  
            insert ap;
            return ap.Id;
        }

   		
    }
    
}
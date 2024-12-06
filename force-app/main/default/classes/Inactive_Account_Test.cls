@isTest
public class Inactive_Account_Test {
    @isTest
    public static void Test1(){ // check if estimate are added to inactive account.
        Account a=new Account(Name='A1',In_Active__c=true);
        insert a;
        Estimation__c e=new Estimation__c(Estimate_Id__c='1',Account__c=a.Id);
        Test.startTest();
        Database.insert(e,false);
        Test.stopTest();
        Integer count=(Integer)[select Count(Id) c from Estimation__c where Account__c=:a.id][0].get('c');
        System.assertEquals(0, count);
    }
    @isTest
    public static void Test2(){// check if estimate Id are prefixed with Q
        Account a=new Account(Name='A1',In_Active__c=false);
        insert a;
        List<Estimation__c> est=new List<Estimation__c>();
        est.add(new Estimation__c(Estimate_Id__c='1',Account__c=a.Id));
        est.add(new Estimation__c(Estimate_Id__c='2',Account__c=a.Id));
        insert est;
        a.In_Active__c=true;
        Test.startTest();
        update a;
        Test.stopTest();
        Integer count=(Integer)[select Count(Id) c from Estimation__c where Account__c=:a.Id AND Estimate_Id__c like 'Q%'][0].get('c');
        System.assertEquals(2,count);
    }
    	@isTest
        public static void Test3(){// check if estimate Id are prefixed with Q are removed
        Account a=new Account(Name='A1',In_Active__c=false);
        insert a;
        List<Estimation__c> est=new List<Estimation__c>();
        est.add(new Estimation__c(Estimate_Id__c='1',Account__c=a.Id));
        est.add(new Estimation__c(Estimate_Id__c='2',Account__c=a.Id));
        insert est;
        a.In_Active__c=true;
        update a;
        a.In_Active__c=false;
        Test.startTest();
        update a;
        Test.stopTest();
        Integer count=(Integer)[select Count(Id) c from Estimation__c where Account__c=:a.Id AND Estimate_Id__c like 'Q%'][0].get('c');
        System.assertEquals(0,count);
    }
    @isTest
    public static void Test4(){// Updating Estimates in Inactive Account.
        Account a=new Account(Name='A1',In_Active__c=false);
        insert a;  
        Estimation__c e=new Estimation__c(Estimate_Id__c='1',Account__c=a.Id);
        insert e;
        a.In_Active__c=true;
        update a;
        e.Estimate_Id__c='121';
        Test.startTest();
        Database.update(e,false);
        Test.stopTest();
        Integer count=(Integer)[select COUNT(Id) c from Estimation__c where Account__c=:a.Id AND Estimate_Id__c='121'][0].get('c');
        System.assertEquals(0,count);
    }
}
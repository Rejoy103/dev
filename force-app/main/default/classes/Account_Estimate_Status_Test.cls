@isTest
public class Account_Estimate_Status_Test {
	@isTest
    public static void ITest1(){
        Account a=new Account(Name='Testacc');
    	insert a;
        List<Estimation__c> est=new list<Estimation__c>();
        est.add(new Estimation__c(Account__c=a.Id,Status__c='Proposed',Estimate_Id__c='E#001'));
        est.add(new Estimation__c(Account__c=a.Id,Status__c='In Progress',Estimate_Id__c='E#002'));
        Test.startTest();
        insert est;
        Test.stopTest();
        Integer m=(Integer)[select Current_Status_Map__c from Account where Id=:a.Id][0].Current_Status_Map__c;
        System.assertEquals(1, m);
    }
		@isTest
    public static void ITest2(){
        Account a=new Account(Name='Testacc');
    	insert a;
        List<Estimation__c> est=new list<Estimation__c>();
        est.add(new Estimation__c(Account__c=a.Id,Status__c='In Progress',Estimate_Id__c='E#001'));
        est.add(new Estimation__c(Account__c=a.Id,Status__c='Accepted',Estimate_Id__c='E#002'));
        Test.startTest();
        insert est;
        Test.stopTest();
        Integer m=(Integer)[select Current_Status_Map__c from Account where Id= :a.Id][0].Current_Status_Map__c;
        System.assertEquals(2, m);
    }
        public static void ITest3(){
        List<Account> acc=new List<Account>();
        acc.add(new Account(Name='Testacc'));
        acc.add(new Account(Name='Testacc2'));
    	insert acc;
        List<Estimation__c> est=new list<Estimation__c>();
        est.add(new Estimation__c(Account__c=acc[0].Id,Status__c='In Progress',Estimate_Id__c='E#001'));
        est.add(new Estimation__c(Account__c=acc[0].Id,Status__c='Accepted',Estimate_Id__c='E#002'));
        est.add(new Estimation__c(Account__c=acc[1].Id,Status__c='Accepted',Estimate_Id__c='E#0021'));
        est.add(new Estimation__c(Account__c=acc[1].Id,Status__c='Accepted',Estimate_Id__c='E#0023'));
        Test.startTest();
        insert est;
        Test.stopTest();
        Integer m1=(Integer)[select Current_Status_Map__c from Account where Id= :acc[0].Id][0].Current_Status_Map__c;
        Integer m2=(Integer)[select Current_Status_Map__c from Account where Id= :acc[1].Id][0].Current_Status_Map__c;
        System.assertEquals(2, m1);
            System.assertEquals(3, m1);
    }
    @isTest
    public static void UTest1(){
        Account a=new Account(Name='Test1');
        insert a;
        Estimation__c e1=new Estimation__c(Account__c=a.Id,Status__c='In Progress',Estimate_Id__c='E#001');
        insert e1;
        e1.Status__c='Proposed';
        Test.startTest();
        update e1;
        Test.stopTest();
        Integer m=(Integer)[select Current_Status_Map__c from Account where Id=:a.Id][0].Current_Status_Map__c;
        System.assertEquals(1, m);
    }
}
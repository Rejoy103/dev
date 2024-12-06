@isTest
public class StandardContactTest {
    
    @isTest
    static void CheckForStandardInsert(){ //Adding 2 Standard contact to one account 
        Account a=new Account(Name='ABC Company');//rejoy-king-ston-dev-ed.my.salesforce.com/_ui/common/apex/debug/ApexCSIPage#
        insert a;
        List<Contact> con=new List<Contact>();
        Contact c=new Contact();
        c.AccountId=a.Id;
        c.FirstName='Test0001';
        c.LastName='Test';
        c.Type_of_Contact__c='Standard';
        con.add(c);
        Contact c1=new Contact();
        c1.AccountId=a.Id;
        c1.FirstName='Test002';
        c1.LastName='Test12';
        c1.Type_of_Contact__c='Standard';
        con.add(c1);
        Test.startTest();
        insert con;
        Test.stopTest();
        AggregateResult arr=[select Count(Id) c from Contact];
        System.assertEquals(1, (Integer)arr.get('c'));
    }
    @isTest
    static void StandardWithGeneral(){// adding 2 standard and 1 general contact
        Account a=new Account(Name='ABC Company');
        insert a;
        List<Contact> con=new List<Contact>();
        Contact c=new Contact();
        c.AccountId=a.Id;
        c.FirstName='Test0001';
        c.LastName='Test';
        c.Type_of_Contact__c='Standard';
        con.add(c);
        Contact c1=new Contact();
        c1.AccountId=a.Id;
        c1.FirstName='Test002';
        c1.LastName='Test12';
        c1.Type_of_Contact__c='Standard';
        con.add(c1);
        Contact c2=new Contact();
        c2.AccountId=a.Id;
        c2.FirstName='Test0023';
        c2.LastName='Test123';
        c2.Type_of_Contact__c='General';
        con.add(c2);
        Test.startTest();
        Database.insert(con,false);
        Test.stopTest();
        AggregateResult arr=[select Count(Id) c from Contact];
        System.assertEquals(2, (Integer)arr.get('c'));
    }
    @isTest
    static void UpdateGeneralToStandard(){//updating a contact to standard
        Account a=new Account(Name='ABC Company');
        insert a;
        Contact c=new Contact();
        c.AccountId=a.Id;
        c.FirstName='Test0001';
        c.LastName='Test';
        c.Type_of_Contact__c='Standard';
        Contact c1=new Contact();
        c1.AccountId=a.Id;
        c1.FirstName='Test002';
        c1.LastName='Test12';
        c1.Type_of_Contact__c='General';
        insert c1;
        insert c;
        c1.Type_of_Contact__c='Standard';
        Test.startTest();
        Database.update(c1,false);
        Test.stopTest();
        List<Contact> tc=[select Type_of_Contact__c From Contact where id=:c1.Id];
        System.assertEquals('General',tc[0].Type_of_Contact__c);
    }
}
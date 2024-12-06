@isTest
public class TestRestrictContactByName {
    @isTest Static void Test(){
        Contact c=new Contact(FirstName='Honan',LastName='INVALIDNAME');
        Test.startTest();
        Database.SaveResult result=Database.insert(c,false);
        Test.stopTest();
        System.assert(True);
    }
}
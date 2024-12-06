@isTest
public class TestData {
    @isTest static void Test1(){
        List<Contact> res=RandomContactFactory.generateRandomContacts(1,'hills');
            System.assertEquals('Test1',res[0].FirstName);
    }
}
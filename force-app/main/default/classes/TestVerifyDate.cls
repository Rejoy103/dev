@isTest
public class TestVerifyDate {
    @isTest static void TestCrt(){
        System.assertEquals(date.newInstance(2020, 2, 3), VerifyDate.CheckDates(date.newInstance(2020, 2, 1),date.newInstance(2020, 2, 3)));
    }
    @isTest static void TestWrong(){
        System.assertEquals(date.newInstance(2020, 2, 29), VerifyDate.CheckDates(date.newInstance(2020, 2, 1),date.newInstance(2020, 3, 3)));
    }
}
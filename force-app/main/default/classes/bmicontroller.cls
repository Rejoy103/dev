public class bmicontroller {
    @AuraEnabled
    public static id createEntry(String username,Decimal h,decimal w,decimal b,string t){
        BMI__c[] bmi=[SELECT id,Name,height__c,weight__c,bmi__c,type__c FROM BMI__c where Name=:username limit 1];
        if(bmi.size() != 0){
            bmi[0].Height__c=h;
            bmi[0].Weight__c=w;
            bmi[0].bmi__c=b;
            bmi[0].Type__c=t;
            update bmi[0];
            return bmi[0].Id;
        }else{
            System.debug('Inside create');
            BMI__c bmii=new BMI__c();
            bmii.Name=username;
            bmii.Height__c=h;
            bmii.Weight__c=w;
            bmii.bmi__c=b;
            bmii.Type__c=t;
            insert bmii;
            return bmii.Id;
        }
    }
}
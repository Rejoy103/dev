public class UpdatePostpaid implements Schedulable {
    public void execute(SchedulableContext w){
        Date d=System.today();
        List<Active_Plan__c> ap=[select Payment_Status__c,	Plan_Start_Date__c from Active_Plan__c where RecordType.Name='Postpaid' and Plan_End_Date__c<=:d];
        for(Active_Plan__c c : ap){
        }
        update ap;
    }
}
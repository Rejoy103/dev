trigger UpdateisActive on Active_Plan__c (after insert) {
    System.debug(Trigger.new);
    List<Plan_Customer__c> cl=new List<Plan_Customer__c>();
    for(Active_Plan__c i : Trigger.new){
        Plan_Customer__c c=[SELECT Name,HasActivePlan__c,Email__c FROM Plan_Customer__c WHERE Id=:i.Customer__c];
        Data_Plan__c dp=[Select Name FROM Data_Plan__c WHERE Id=:i.Data_Plan__c];
    	String s='Plan Successfully Activated';
        String b='Hi ' + c.Name + '<br>' + '			The following plan | '+dp.Name+' has been activated. This plan expires on '+i.Plan_End_Date__c +'.';
        String f='Thanks & Regards<br>Data Plan App';
        String t=c.Email__c; 
        SendMail sm=new SendMail(s,b,f,t);
        c.HasActivePlan__c=true;
        cl.add(c);
        sm.sendMail();
    }
    update cl;
}
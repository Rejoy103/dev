public class DeleteExpired implements Schedulable {
    public void execute(SchedulableContext c){
        Date md=System.today();
        List<Active_Plan__c> al=[SELECT Name FROM Active_Plan__c WHERE Plan_End_Date__c<=:md];
        List<Plan_Customer__c> cu=new List<Plan_Customer__c>();
        for(Active_Plan__c i : al){
            Plan_Customer__c x=[select Name,Email__c,HasActivePlan__c from Plan_Customer__c where Id=:i.Customer__c];
            String s='Plan Expried';
            String b='Hi '+ x.Name + '<br>Your current plan has been expired. Please recharge to continue service.';
            String f='Thanks & Regards<br>Data Plan App';
        	String t=x.Email__c; 
            x.HasActivePlan__c=false;
            cu.add(x);
            SendMail sm=new SendMail(s,b,f,t);
            sm.sendMail();
    	}
    update cu;
    delete al;
	}
}
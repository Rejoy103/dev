public  class Estimate_Controller {

    public final Account acc{get;private set;}
    public ApexPages.StandardSetController est{
        get{
            if(est==null){
                est= new ApexPages.StandardSetController(Database.getQueryLocator([select Charge_1__c,Charge_2__c,Total_Estimation__c,Status__c from Estimation__c where Account__c=:acc.Id]));
            }
            return est;
        }
        set;
    }
    public ApexPages.StandardSetController cts{
        get{
            if(cts==null){
                            cts=new ApexPages.StandardSetController(Database.getQueryLocator([select FirstName,LastName,Phone,Email from Contact where Contact.AccountId=:acc.Id]));

            }
             	return cts;
        }
        set;
    }
    public Estimate_Controller(){
        Id id=ApexPages.currentPage().getParameters().get('id');
        acc=(id==null)?new Account():[Select Id,Name,Total_Estimation__c from Account where Id=:id];
    }
   
    public List<Estimation__c> getEstimations(){
        return (List<Estimation__c>) est.getRecords();
    }
    
    public List<Contact> getContacts(){
        return (List<Contact>) cts.getRecords();
    }
}
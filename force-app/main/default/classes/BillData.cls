public class BillData {
    public final Purchase__c pur{get;private set;}
    
     public ApexPages.StandardSetController itm{
        get{
            if(itm==null){
                            itm=new ApexPages.StandardSetController(Database.getQueryLocator([select Name__c,Item_No__c,Unit_Price__c,Quantity__c,Total_Price__c from Item__c where Purchase__c=:pur.Id]));

            }
             	return itm;
        }
        set;
    }
    public BillData(){
        Id id=ApexPages.currentPage().getParameters().get('id');
        pur=(id==null)?new Purchase__c():[Select Id,Name,Total__c,Grand_Total__c,Total_Items__c from Purchase__c where Id=:id];
    }
    public list<Item__c> getItems(){
        return(List<Item__c>) itm.getRecords();
    }
}
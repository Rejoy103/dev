public class EstimationExtension {
    private final Account acc;
    public ApexPages.StandardSetController ssc{
        get{
            if(ssc==null){
                ssc=new ApexPages.StandardSetController(Database.getQueryLocator([select Charge_1__c,Charge_2__c,Total_Estimation__c,Status__c from Estimation__c where Account__c=:acc.Id]));
            }
            return ssc;
        }
        set;
    } 
    public EstimationExtension(ApexPages.StandardController std){
        acc=(Account)std.getRecord();
    }
    public List<Estimation__c> getEstimation(){
        return (List<Estimation__c>) ssc.getRecords();
    }
}
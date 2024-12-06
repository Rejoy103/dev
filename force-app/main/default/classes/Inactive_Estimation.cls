public class Inactive_Estimation {
	@InvocableMethod(Label='Update Estimation on InActive Account')
    public static void Estimation_Inactive(List<String> x){
        List<Estimation__c> es=[select Estimate_Id__c from Estimation__c where Account__c in :x AND Account__r.In_Active__c=true];
        List<Estimation__c> refes=[select Estimate_Id__c from Estimation__c where Estimate_Id__c like 'Q%'];
        List<String> refesid=new List<String>();
        for(Estimation__c i:refes){
            refesid.add(i.Estimate_Id__c);
        }
        for(Estimation__c i:es){
            do{
                i.Estimate_Id__c='Q'+i.Estimate_Id__c;
            }while(refesid.contains(i.Estimate_Id__c));
        }
        if(es.size()>0)update es;
    }
    
}
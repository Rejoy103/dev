public class Bullk_Estimate_Flow {
    @InvocableMethod(label='Bulk Estimate ID Insertion')
    public static List<Result> Bulk_Estimate_Insert(List<Input> input){
       	List<String> ids=input.get(0).eids.split(',');//Splitting to individual ID
    	Result result=new Result();// Returning Final Result
        List<Estimation__c> estobj=new List<Estimation__c>();
        for(String i:ids){
            estobj.add(new Estimation__c(Estimate_Id__c=i,Account__c=input.get(0).accid));
        }
      	Database.SaveResult[] sr=Database.insert(estobj,false);
        for(Integer i=0;i<estobj.size();i++){
            Database.SaveResult r=sr.get(i);
            if(r.isSuccess()){
                result.successrow++;
                //System.debug('Success : ' + estobj.get(i).Estimate_Id__c);
            }else{
                result.failedrow++;
                result.invalidid+=estobj.get(i).Estimate_Id__c+ ' ';
                //System.debug('Failed : ' + estobj.get(i).Estimate_Id__c);
            }
        }
        List<Result> reslist=new List<Result>();
        reslist.add(result);
        return (reslist);
    }
    
    public class Input{
        @InvocableVariable
        public String eids;
        @InvocableVariable
        public String accid;  
    }
    public class Result{
        @InvocableVariable
        public Integer successrow=0;
        @InvocableVariable
        public Integer failedrow=0;
        @InvocableVariable
        public string invalidid='';
        
    }
}
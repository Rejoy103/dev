public class TripDairy_Login_Helper {
	@AuraEnabled
    public static Boolean checkUserNameExsist(String data){
        Map<String,Object> dataJson= (Map<String,Object>)json.deserializeUntyped(data);
        List<Member__c> mem=new List<Member__c>();
        mem=[SELECT id from Member__c WHERE Username__c=:String.valueof(dataJson.get('userName')) or Email__c=:String.valueof(dataJson.get('email')) limit 1];
        if(mem.size() > 0){
            return true;
        }else{
            return false;
        }
    }
}
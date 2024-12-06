public class AccountTestClass {
    String CurrentUsersProfile=[Select Name from profile where Id=:UserInfo.getProfileId()].Name;
    public void run(){
        List<Id> ids=new List<Id>();
        for(Account a:(List<Account>) Trigger.New){
            ids.add(a.id);
        }
        List<Account> acc=[SELECT id,CustomerPriority__c,In_Active__c FROM Account where id in :ids];
        for(Account a:acc){
            a.CustomerPriority__c='Low';
            a.In_Active__c=true;
        }
    }
}
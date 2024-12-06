public class ContactHelper extends TriggerHandlerBase {
    protected override void beforeinsert(List<sObject> x){
        Set<Id> accid=new Set<Id>(); // Account ids for which the new contacts are created with standard type.
        set<Id> accountstolookfor=new set<Id>();
        for(Contact contact:(List <Contact>)x){
            if(contact.Type_of_Contact__c=='Standard'){
                accid.add(contact.AccountId);
            }
        }
        //Getting the count of standard contacts for the following account.
        List<Contact> cwithaid=[Select AccountId from Contact where AccountId IN :accid AND Type_of_Contact__c='Standard'];
        for(Contact c:cwithaid)accountstolookfor.add(c.AccountId);
        for(Contact c:(List<Contact>)x){
            if(c.Type_of_Contact__c=='Standard'){
                if(!accountstolookfor.contains(c.AccountId)){ // Checking if the following Account already has a standard contact
                     accountstolookfor.add(c.AccountId); //if not add to map, such that we can prevent another contact in this batch from inserting into same account.         
                }else{
                    c.Type_of_Contact__c.addError('Only one Standard Contact is allowed');
                }
        }
        }
    }
    protected override void beforeupdate(map<Id,sObject> old,map<Id,sObject> ne){
        Set<Id> accid=new Set<Id>();
        Set<Id> accountstolookfor=new Set<Id>();
        for(Contact c:(List<Contact>)ne.values()){
            if(c.Type_of_Contact__c != ((Contact)old.get(c.Id)).Type_of_Contact__c && c.Type_of_Contact__c=='Standard'){
               accid.add(c.AccountId);
            }
        }
        List<Contact> arr=[Select AccountId  from Contact where AccountId IN :accid AND Type_of_Contact__c='Standard'];
        for(Contact c:arr)accountstolookfor.add(c.AccountId);
        for(Contact c:(List<Contact>)ne.values()){
            if(accountstolookfor.contains(c.AccountId)){
                c.Type_of_Contact__c.addError('Only one Standard Contact is allowed');
            }
        }
    }
}
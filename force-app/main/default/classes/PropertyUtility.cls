public class PropertyUtility {
    public static void newListedProperties(){
        List<Property__c> newPropList =new List<Property__c>();
        newPropList=[SELECT Name,Broker__r.Email__c,Days_On_Market__c FROM Property__c];
        String propEmail;
        for(Property__c i : newPropList){
            propEmail += i.Name + ' : ' + i.Broker__r.Email__c;
        }
        System.debug(propEmail);
    }
}
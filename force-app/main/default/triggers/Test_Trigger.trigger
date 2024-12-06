trigger Test_Trigger on Test__c (before insert) {
    if(Trigger.IsInsert){
        system.debug('Before Insert');
    }
}
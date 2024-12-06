trigger Test_ContentDocumentLink on ContentDocumentLink (before insert,before update,after insert,after update) {
 if(Trigger.isBefore){
        if(Trigger.isInsert){
            system.debug('CDL-Before Insert');
        }
        if(Trigger.isUpdate){
            system.debug('CDL-before update');
        }
    }else{
        if(Trigger.isInsert){
            system.debug('CDL-After Insert');
        }
        if(Trigger.isUpdate){
            system.debug('CDL-After update');
        }
    }
}
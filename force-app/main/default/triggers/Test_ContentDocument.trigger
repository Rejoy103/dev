trigger Test_ContentDocument on ContentDocument (before insert,before update,after insert,after update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            system.debug('CD-Before Insert');
        }
        if(Trigger.isUpdate){
            system.debug('CD-before update');
        }
    }else{
        if(Trigger.isInsert){
            system.debug('CD-After Insert');
        }
        if(Trigger.isUpdate){
            system.debug('CD-After update');
        }
    }
}
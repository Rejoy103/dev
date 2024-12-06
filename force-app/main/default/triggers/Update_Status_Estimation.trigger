trigger Update_Status_Estimation on Estimation__c (before insert,before update,after insert,after update,after delete) {
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
           //Estimation_Helper.Check_For_Active_Update(Trigger.oldMap,Trigger.newMap);
        }
    }else if(Trigger.isAfter){
            if(Trigger.isInsert){
      	Estimation_Helper.Insert_Operation(Trigger.new);
    }else if (Trigger.isUpdate){
        Estimation_Helper.Update_Operation(Trigger.oldMap,Trigger.newMap);
    }else if(Trigger.isDelete){
            Estimation_Helper.Delete_Operation(Trigger.old);
        }
    }


}
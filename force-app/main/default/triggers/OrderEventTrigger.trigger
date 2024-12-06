trigger OrderEventTrigger on Order_Event__e (after insert) {
    List<Task> tasks=new List<Task>();
    for(Order_Event__e e:Trigger.new){
        if(e.Has_Shipped__c==true){
            Task t=new Task();
            t.Priority='Medium';
            t.Subject='Follow up on shipped order 105';
            t.OwnerId=e.CreatedById;
            tasks.add(t);
        }
    }
    insert tasks;
}
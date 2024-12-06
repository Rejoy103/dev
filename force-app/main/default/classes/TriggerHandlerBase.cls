public virtual class TriggerHandlerBase {
    public void run(){
        if(Trigger.isBefore){
            if(Trigger.isInsert){
                System.debug('Inside beforeinsert');
                this.beforeinsert(Trigger.new);
            }
            else if(Trigger.isUpdate){
                this.beforeupdate(Trigger.oldMap,Trigger.newMap);
            }
        }
    }
    protected virtual void beforeinsert(List<sObject> obj){}
    protected virtual void beforeupdate(map<Id,sObject> old,map<Id,sObject> ne){}
    
}
trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
	/*list<Task> s=new list<Task>();
    for (Opportunity o:[SELECT Id FROM Opportunity WHERE StageName='Closed Won']){
        s.add(new Task(Subject='Follow Up Test Task',WhatId=o.Id));
    }
    if(s.size()>0){
        upsert s;
    }*/
}
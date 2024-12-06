({
	doInit : function(component, event, helper) {
		var Expenseid=component.get("v.recordId");
	},
    callvfpage : function (component, event, helper) {
    	var recordId = component.get('v.recordId');
    	var url;
    	var urlEvent;
        url = window.open('/apex/ExpenseSheet?id=' + recordId, 'target=_blank'); 
        window.location.replace('/one/one.app?#/sObject/'+ recordId + '/view' ) ; 
        urlEvent.fire();
	},
      savePDF : function(component) {
        console.log('in savepdf');
		var action = component.get("c.attachPDF");
        var recID=component.get('v.recordId');
        console.log("--recId--"+recID);
        action.setParams({ expenseId : recID });
        action.setCallback(this, function(response) {
        var attachId = response.getReturnValue();
            console.log("---"+attachId);
        var state = response.getState();
            if (state === "SUCCESS") {
                
                $A.get('e.force:refreshView').fire();
               
                $A.get('e.force:closeQuickAction').fire();
                alert("File is added to Attachments as PDF")
                      
            }
            else { 
                alert("File could not be  added to Attachments ");}
         console.log(attachId);
        });
        $A.enqueueAction(action);
    }
})
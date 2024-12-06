({
    init : function(component,event,helper){
        $A.get("e.force:navigateToSObject").setParams({
        "recordId":component.get("v.recId"),
        "slideDevName":"Details"
        }).fire();
    },
    invoke : function(component,event,helper){
        $A.get("e.force:navigateToSObject").setParams({
        "recordId":component.get("v.recId"),
        "slideDevName":"Details"
        }).fire();
    }
})
@RestResource(urlMapping='/Expense/*')
global class ExpenseAPI {
	@HttpGet
    global static List<ExpenseItemApp__c> getItems(){
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        String Dat=req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        system.debug(Dat);
        List<ExpenseItemApp__c> expenseitm=new List<ExpenseItemApp__c>();
        try{
            expenseitm=[select Id,Name__c,Expense_Tyoe__c,Date__c,Amount__c,Mode__c from ExpenseItemApp__c where Expense__c=:Dat];
            system.debug(expenseitm);
        }catch(Exception e){
            
        }
	        return expenseitm;
    } 
}
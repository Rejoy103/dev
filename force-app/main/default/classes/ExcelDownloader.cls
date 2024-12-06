public class ExcelDownloader {
	@AuraEnabled(cacheable=true)
    public static List<ExpenseItemApp__c> getExpenseList(){
        return [select Id,Date__c,Amount__c,Mode__c,Expense_Tyoe__c from ExpenseItemApp__c];
    }
}
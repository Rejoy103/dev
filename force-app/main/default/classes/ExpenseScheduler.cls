global class ExpenseScheduler implements Schedulable{
	global void execute(SchedulableContext SC) {
      createExpense();
   }
    private void createExpense(){
        List<ExpenseCustom__c> Expense=[select Id,Name,Date__c,	Active__c,Balance__c,Total_Saving__c from ExpenseCustom__c where Active__c=true];//Jul-2022
        List<ExpenseItemApp__c> Items=[select Id from ExpenseItemApp__c where 	Expense__c =:Expense[0].Id ];
        if(Expense != null){
            Expense[0].Active__c=false;
            update(Expense);
            PageReference pdf =  Page.ExpenseSheet;
            pdf.getParameters().put('id',Expense[0].Id);
            Blob b=pdf.getContentAsPDF();
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setContentType('application/pdf');
            efa.setFileName('Expensesheet_'+Expense[0].Name+'.pdf');
            efa.setInline(false);
            efa.setBody(b);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {'rejoykingston@gmail.com'};
            mail.setToAddresses(toAddresses);
            mail.setSubject('Month Expense'); 
            mail.plainTextBody = 'Hi Rejoy\nThis month expense report.';
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
            Messaging.SendEmail(new Messaging.SingleEmailMessage[] {mail});
            if(Items.size()>0){
                delete Items;
            }
        }
        DateTime dt=System.today();
        String ExpenseName=dt.format('MM-yyyy');
        ExpenseCustom__c ec=new ExpenseCustom__c();
        ec.Name=ExpenseName;
        ec.Active__c=true;
      	ec.Date__c=System.today();
        ec.Total_Saving_back__c=Expense[0].Total_Saving__c;
        if(Expense[0].Balance__c > 0){
            ec.Carry_Over__c=Expense[0].Balance__c;
        }
        insert ec;
		if(Expense.size() >0)delete Expense;
    }
}
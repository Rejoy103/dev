public class Expense_Controller {
    public final ExpenseCustom__c expense{get;private set;}
    public list<ExpenseItemApp__c> items{get;set;}
    public Double monthly{get;private set;}
    public Double TotalExpense{get;private set;}
    public string trendReport{get;private set;}
    private string trenddate{get;set;}
    private string trendamount{get;set;}
    public Double FoodPercentage{get;set;}
    public Double MonthPercentage{get;set;}
    public Double ElecPercentage{get;set;}
    public Double TravelPercentage{get;set;}
    public Double MisPercentage{get;set;}
    public Double CosPercentage{get;set;}
    public Double Saving{get;set;}
     public Double PreSaving{get;set;}
     public Double TotalSaving{get;set;}
  
    public Expense_Controller(){
        Id id=ApexPages.currentPage().getParameters().get('id');
        this.expense=(id==null)?new ExpenseCustom__c():[Select Id,Name,Monthly_Allowance__c,Total_Saving_back__c,Total_Saving__c,Savings__c,Balance__c,Used__c,S_E_Ratio__c,Carry_Over__c from ExpenseCustom__c where Id=:id];
        this.items=[select Id,Name__c,Expense_Tyoe__c,Date__c,Amount__c,Mode__c from ExpenseItemApp__c where Expense__c=:expense.Id order by Date__c asc limit 2000];
        monthly=Expense.Monthly_Allowance__c - Expense.Savings__c;
        Saving=expense.Savings__c;
        PreSaving=expense.Total_Saving_back__c;
        TotalSaving=expense.Total_Saving__c;
        List<ExpenseItemApp__c> expenseitem=[select Id,Date__c,Amount__c,Mode__c,Expense_Tyoe__c from ExpenseItemApp__c where Expense__c=:expense.Id order by Date__c asc];
        List<AggregateResult> pers=[select Expense_Tyoe__c t,SUM(Amount__c) per from ExpenseItemApp__c where Expense__c=:expense.Id and Mode__c='Debit' group by Expense_Tyoe__c];
        for(AggregateResult i:pers){
            if(i.get('t')=='Food')FoodPercentage=(Double)i.get('per');
            if(i.get('t')=='Monthly Expense')MonthPercentage=(Double)i.get('per');
            if(i.get('t')=='Cosmetics')CosPercentage=(Double)i.get('per');
            if(i.get('t')=='Miscellaneous')MisPercentage=(Double)i.get('per');
            if(i.get('t')=='Electronic')ElecPercentage=(Double)i.get('per');
            if(i.get('t')=='Travel')TravelPercentage=(Double)i.get('per');  
        }
        if(expenseitem != null){
                    for(ExpenseItemApp__c e:expenseitem){
                        if(e.Mode__c=='Debit'){
                            if(TotalExpense==null)TotalExpense=e.Amount__c;
                        	else TotalExpense+=e.Amount__c;
                        }
        			}
            FoodPercentage=FoodPercentage!=null?math.round((FoodPercentage/TotalExpense)*100):0;
            MonthPercentage=MonthPercentage!=null?math.round((MonthPercentage/TotalExpense)*100):0;
            ElecPercentage=ElecPercentage!=null?math.round((ElecPercentage/TotalExpense)*100):0;
            MisPercentage=MisPercentage!=null?math.round((MisPercentage/TotalExpense)*100):0;
            TravelPercentage=TravelPercentage!=null?math.round((TravelPercentage/TotalExpense)*100):0;
            CosPercentage=CosPercentage!=null?math.round((CosPercentage/TotalExpense)*100):0;
        }
    }
    @AuraEnabled
    public static void test(){
        system.debug('in');
    }
    @AuraEnabled
    public static id attachPDF(Id expenseId){
        blob expensePdf;
        ExpenseCustom__c expense = new ExpenseCustom__c();
        PageReference reportPage;
        System.debug(expenseId);
        expense=[select id,Name,Contact__c from ExpenseCustom__c where id=:expenseId];
        if(expense.Contact__c == null)return null;
        reportPage=Page.ExpenseSheet;
        if(reportPage != null){
            reportPage.getParameters().put('id',expense.id);
            try{expensePdf=reportPage.getContentAsPDF();}
            catch(VisualForceException e){expensePdf = Blob.valueOf(e.getMessage());}
        }
        string doctitle='Expense_'+expense.Name;
        string docversion='v1';
        List<ContentDocumentLink> conDocu = [SELECT LinkedEntityId,ContentDocumentId FROM ContentDocumentLink where LinkedEntityId =: expense.Contact__c];
        set<Id> docids=new Set<id>();
        for(ContentDocumentLink i:conDocu){
            docids.add(i.ContentDocumentId);
        }
        List <ContentVersion> existingConDocVersions = [SELECT ContentDocumentId, VersionNumber FROM ContentVersion WHERE Title LIKE :(doctitle + '%') AND IsLatest=True  AND ContentDocumentId IN: docids];
        if(existingConDocVersions.size()>0){
            Id existingConDoc = existingConDocVersions[0].ContentDocumentId;
            docversion = 'V' + (Integer.valueOf(existingConDocVersions[0].VersionNumber) + 1);
            ContentVersion cvn ;
            cvn = new ContentVersion();
            cvn.VersionData = expensePdf;
            cvn.Title = doctitle + ' ' + docversion;
            cvn.ContentLocation= 's';
            cvn.PathOnClient=doctitle + ' ' + docversion +'.pdf';
            cvn.ContentDocumentId = existingConDoc;
            insert cvn;
            return cvn.id;
        }
        ContentVersion ncv=new ContentVersion();
        ncv.VersionData=expensePdf;
        ncv.Title=doctitle + ' ' + docversion;
        ncv.ContentLocation='s';
        ncv.PathOnClient=doctitle + ' ' + docversion +'.pdf';
        insert ncv;
        
        ContentDocumentLink ncdl=new ContentDocumentLink();
        id cvid=[select ContentDocumentId from ContentVersion where id=:ncv.Id].ContentDocumentId;
        ncdl.ContentDocumentId=cvid;
        ncdl.LinkedEntityId=expense.Contact__c;
        ncdl.ShareType = 'I';
        ncdl.Visibility = 'AllUsers';
        insert ncdl;
        return ncv.id;
    }
}
public class NewCaseListController {
    public List<Case> getNewCases(){
        return [Select Id,CaseNumber From Case where Status='New'];
    }
}
public with sharing class Expense_Extension {
  ApexPages.StandardSetController controller;    

    public void Expense_Extension(ApexPages.StandardSetController controller) {
    this.controller = controller;        
    controller.setPageSize(controller.getResultSize());
    }
}
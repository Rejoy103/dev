import { LightningElement, wire } from 'lwc';
import getExpenseList from '@salesforce/apex/ExcelDownloader.getExpenseList'

export default class ExcelDownload extends LightningElement {
    expensedata

    @wire(getExpenseList)
    handleResponse({error,data}){
        if(data){
            this.expensedata=data;
        }else if(error){
            console.error(error);
        }
    }
    columnHeader=["Id","Date","Amount","Mode","Type"];
    handleDownload(){
        console.log("in");
        let doc="<table>"
        doc += '<style>';
        doc += 'table, th, td {';
        doc += '    border: 1px solid black;';
        doc += '    border-collapse: collapse;';
        doc += '}';          
        doc += '</style>';
        // Add all the Table Headers
        doc += '<tr>';
        this.columnHeader.forEach(element => {            
            doc += '<th>'+ element +'</th>'           
        });
        doc += '</tr>';
        // Add the data rows
        this.expensedata.forEach(record => {
            doc += '<tr>';
            doc += '<th>'+record.Id+'</th>'; 
            doc += '<th>'+record.Date__c+'</th>'; 
            doc += '<th>'+record.Amount__c+'</th>';
            doc += '<th>'+record.Mode__c+'</th>'; 
            doc += '<th>'+record.Expense_Tyoe__c+'</th>'; 
            doc += '</tr>';
        });
        doc += '</table>';
        var element='data:application/vnd.ms-excel, ' + encodeURIComponent(doc);
        let downloadElement=document.createElement('a');
        downloadElement.href=element;
        downloadElement.target="_self";
        downloadElement.download="expense.csv";
        document.body.append(downloadElement);
        downloadElement.click();
    }
}
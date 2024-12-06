import { LightningElement,wire,api } from 'lwc';
import {getListUi} from 'lightning/uiListApi';
import { updateRecord,deleteRecord } from 'lightning/uiRecordApi';
import EXPENSEITEM from '@salesforce/schema/ExpenseItemApp__c'
import DATE from '@salesforce/schema/ExpenseItemApp__c.Date__c'
import { getDataConnector } from 'lightning/analyticsWaveApi';

export default class ExpenseList extends LightningElement {
    @api recordId;
    expense=[]
    draft=[]
    deleteRecords=[]
    canDelete=false
    col=[{label:'Name',fieldName:'Name__c'},
         {label:'Date',fieldName:'Date__c'},
         {label:'Type',fieldName:'Expense_Tyoe__c',type:'combo',editable:true},
         {label:'Mode',fieldName:'Mode__c',type:'combo',editable:true},
         {label:'Amount',fieldName:'Amount__c',editable:true}];
    pagetoken=null
    nextpt=null
    prept=null
    @wire(getListUi,{objectApiName:EXPENSEITEM,listViewApiName:"Month_Expense",sortBy:DATE})
    response({data,error}){
        if(data){
            console.log(data);
            this.expense=data.records.records.map(item=>{
                return {
                    'Id':this.getData(item,'Id'),
                    'Name__c':this.getData(item,'Name__c'),
                    'Date__c':this.getData(item,'Date__c'),
                    'Expense_Tyoe__c':this.getData(item,'Expense_Tyoe__c'),
                    'Mode__c':this.getData(item,'Mode__c'),
                    'Amount__c':this.getData(item,'Amount__c')
                };
            })
        }
        if(error){
            console.error(error);
        }
    }
    getData(data,field){
        return data.fields[field].value;
    }

    handleSave(event){
        console.log(JSON.stringify(event.detail.draftValues));
        const recordInput=event.detail.draftValues.map(input=>{
            const fil={...input}
            return {fields:input}
        })
        const promises=recordInput.map(i=>updateRecord(i));
        Promise.all(promises).then(()=>{
            console.log('Records updated successfully');
            this.draft=[];
        }).catch(error=>{
            console.error(error);
        });
        
    }

    handleSelect(event){
        const el=this.template.querySelector('lightning-datatable').getSelectedRows();
        this.deleteRecords=el.map(item=>{
            return item.Id;
        })
        console.log(this.deleteRecords);
        if(this.deleteRecords.length>0){
            this.canDelete=true;
        }else{this.canDelete=false;}
    }

    handleDelete(event){
        console.log('in')
        this.canDelete=false;
        this.deleteRecords=[];
        const promises=this.deleteRecords.map(item=>{
            deleteRecord(item);
        });
        Promise.all(promises).then(()=>{
            console.log('Record Deleted');
        }).catch(error=>{
            console.error(error);
        })
    }
}
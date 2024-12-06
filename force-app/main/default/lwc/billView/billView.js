import { LightningElement,wire,api } from 'lwc';
import { getRecord,getFieldValue  } from 'lightning/uiRecordApi';
import {getRelatedListRecords } from 'lightning/uiRelatedListApi';

import NAME from "@salesforce/schema/Purchase__c.Name";
import ITEM_NAME from "@salesforce/schema/Item__c.Name__c"
import ITEM_QUANTITY from "@salesforce/schema/Item__c.Quantity__c"
import ITEM_PRICE from "@salesforce/schema/Item__c.Total_Price__c"

const fields=[NAME];
const itemfields=[ITEM_NAME,ITEM_PRICE,ITEM_QUANTITY]

export default class BillView extends LightningElement {
    @api recordId;
    relatedrecords;
    error;
    @wire(getRecord,{recordId:"$recordId",fields})purchase;
    @wire(getRelatedListRecords,{parentRecordId:"a0e5j000000dVSgAAM",relatedListId:"Item__c",fields})listrecord({error,data}){
        if(data){
            this.relatedrecords=data.records;
            this.error=undefined;
            console.log("Got record")
        }else if(error){
            this.error=error;
            console.log(error)
            this.relatedrecords=undefined;
        }
    }

    get name(){
        return getFieldValue(this.purchase.data,NAME);
    }
}
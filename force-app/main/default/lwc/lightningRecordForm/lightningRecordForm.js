import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import ACCOUNT from "@salesforce/schema/Account"
import NAME from "@salesforce/schema/Account.Name"
import PHONE from "@salesforce/schema/Account.Phone"
import REVENUE from "@salesforce/schema/Account.AnnualRevenue";

export default class LightningRecordForm extends LightningElement {
    objectapi=ACCOUNT;
    fields=[NAME,PHONE,REVENUE];

    successHandler(event){
        this.dispatchEvent(new ShowToastEvent({
            title:"Account Created",
            message:"Account Created successfully",
            variant:"success"
        }));
    }
}
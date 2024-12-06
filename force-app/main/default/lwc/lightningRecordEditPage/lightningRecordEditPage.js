import { LightningElement } from 'lwc';
import CONTACT from "@salesforce/schema/Contact";
import FIRSTNAME from "@salesforce/schema/Contact.FirstName";
import LASTNAME from "@salesforce/schema/Contact.LastName";
import EMAIL from "@salesforce/schema/Contact.Email";
import ACCOUNT from "@salesforce/schema/Contact.AccountId";

export default class LightningRecordEditPage extends LightningElement {
    objectapi=CONTACT;
    fields={
        firstname:FIRSTNAME,
        lastname:LASTNAME,
        email:EMAIL,
        account:ACCOUNT
    };


    cancelHandler(event){
        this.handleReset();
    }
    handleReset(){
        const inputfield=this.template.querySelectorAll('lightning-input-field');
        console.log("inreset");
        if(inputfield){
            Array.from(inputfield).forEach(i => {
                i.reset();
            });
        }
    }
}
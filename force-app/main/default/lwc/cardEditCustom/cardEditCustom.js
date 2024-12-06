import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import ACCOUNT from "@salesforce/schema/Account"

export default class CardEditCustom extends LightningElement {
    object=ACCOUNT;
    name
    input=''
    changeHandler(event){
        this.input=event.target.value;
    }
    handleSubmit(event){
        event.preventDefault();// prevent refresh of screen
        const inputcom=this.template.querySelector('lightning-input');
        const v=inputcom.value;
        if(!v.includes('India')){
            inputcom.setCustomValidity("Please include India")
        }else{
            inputcom.setCustomValidity("");
            const filed=event.target.fields;
            filed.Name=this.input;
            this.template.querySelector("lightning-record-edit-form").submit(filed);
        }
        inputcom.reportValidity();
    }

    successHandler(event){
        console.log('In Success Handler')
        this.dispatchEvent(new ShowToastEvent({
            title:"Record Created",
            message:"Record ID : "+event.detail.Id,
            variant:"success"
        }));
        this.reset();
    }

    reset(){
        const inputs=this.template.querySelectorAll('lightning-input');
        Array.from(inputs).forEach(i => {
            i.reset();
        })
    }
}
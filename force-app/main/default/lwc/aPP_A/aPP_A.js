import { LightningElement,wire } from 'lwc';
import { publish,MessageContext } from 'lightning/messageService';

import MC from "@salesforce/messageChannel/SampleMessageChannel__c";

export default class APP_A extends LightningElement {
    @wire(MessageContext)context;

    message=""
    inputHandler(event){
        this.message=event.target.value;
    }
    clickHandler(){
        const mess={lmsData:{term:this.message}}
        publish(this.context,MC,mess);
    }
}
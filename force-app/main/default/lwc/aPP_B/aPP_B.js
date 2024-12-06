import { LightningElement, wire } from 'lwc';
import { APPLICATION_SCOPE, MessageContext,subscribe,unsubscribe } from 'lightning/messageService';

import MC from "@salesforce/messageChannel/SampleMessageChannel__c"

export default class APP_B extends LightningElement {
    @wire(MessageContext)context;
    subscription
    Message=""
    connectedCallback(){
        this.subscription=subscribe(this.context,MC,(message)=>{this.handleMessage(message)},{scope:APPLICATION_SCOPE})
    }
    handleMessage(message){
        this.Message=message.lmsData.term?message.lmsData.term:"No Message";
    }
    disconnectedCallback(){
        unsubscribe(this.subscription);
        this.subscription=null;
    }
}
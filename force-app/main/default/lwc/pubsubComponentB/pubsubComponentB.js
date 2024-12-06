import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';

export default class PubsubComponentB extends LightningElement {
    msg=""
    connectedCallback(){
        pubsub.subscribe('message',(props)=>{this.msg=props});
    }
}
import { LightningElement } from 'lwc';
import pubsub from 'c/pubsub';

export default class PubsubComponentA extends LightningElement {
    msg=""
    clickHandler(event){
        pubsub.publish("message",this.msg);
    }
    changeHandler(event){
        this.msg=event.target.value;
    }
}
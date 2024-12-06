import { LightningElement } from 'lwc';

export default class PurchaseForm extends LightningElement {
    itemrecord={}
    newItem(event){
        console.log("in")
        const tr=this.template.querySelector(".test");
        console.log(tr)
        this.template.querySelector('tbody').appendChild(tr)
    }
}
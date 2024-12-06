import { LightningElement } from 'lwc';

export default class C2pModalComponent extends LightningElement {
    closeHandler(event){
        this.dispatchEvent(new CustomEvent("close",{detail:"Closed Successfully"}));
    }
}
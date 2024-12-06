import { LightningElement } from 'lwc';

export default class C2pParentComponent extends LightningElement {
    visible=false
    msg="Nothing"
    clickHandler(event){
        this.visible=true;
    }
    closeWindow(event){
        this.visible=false;
        this.msg=event.detail;
    }
}
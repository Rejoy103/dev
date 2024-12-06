import { LightningElement } from 'lwc';

export default class LifeCycleHook extends LightningElement {
    name
    isVisible
    constructor(){
        super();
        console.log("Parent Component");
    }

    connectedCallback(){
        console.log("Parent connectedCallback");
    }
    renderedCallback(){
        console.log("Parent renderCallback");
    }
    changehandler(event){
        this.name=event.target.value;
    }
    buttonhandler(event){
        isVisible=!isVisible;
    }
}
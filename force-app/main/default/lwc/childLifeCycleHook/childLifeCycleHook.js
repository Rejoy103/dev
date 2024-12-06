import { LightningElement } from 'lwc';

export default class ChildLifeCycleHook extends LightningElement {
    constructor(){
        super();
        console.log("Child Component");
    }

    connectedCallback(){
        console.log("Child connectedCallback");
    }
    renderedCallback(){
        console.log("Child renderCallback");
    }
    disconnectedCallback(){
        console.log("Child disconnectd");
    }
}
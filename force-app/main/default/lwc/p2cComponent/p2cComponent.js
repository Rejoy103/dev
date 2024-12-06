import { LightningElement } from 'lwc';

export default class P2cComponent extends LightningElement {
    percentage=10
    changeHandler(event){
        this.percentage=event.target.value;
        console.log(event.target.value);
    }
    clickHandle(event){
        this.percentage=5
    }
    clickHandler(event){
        this.template.querySelector("c-p2c-slide-component").resetSlider();
    }
}
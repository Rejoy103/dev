import { LightningElement } from 'lwc';

export default class Portfolio_ExtraInfo extends LightningElement {

    education=false
    work=false
    handleEducation(event){
        this.education=true
        this.work=false
    }

    handleWork(event){
        this.education=false
        this.work=true
    }
}
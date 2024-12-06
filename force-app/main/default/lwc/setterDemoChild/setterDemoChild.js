import { LightningElement,api } from 'lwc';

export default class SetterDemoChild extends LightningElement {
    UserDetails={}
    @api
    get details(){
        return(this.UserDetails)
    }
    set details(data){
        this.UserDetails['Name']=data.Name;
        this.UserDetails['Age']=data.Age*2;
    }
}
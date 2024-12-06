import { LightningElement } from 'lwc';
import {NavigationMixin} from "lightning/navigation"
import {encodeDefaultFieldValues} from "lightning/pageReferenceUtils"

export default class NavigateObjectPage extends NavigationMixin(LightningElement) {

    navToRecord(){
        this[NavigationMixin.Navigate]({
            type:"standard__objectPage",
            attributes:{
                objectApiName:"Contact",
                actionName:"new"
            }
        })
    }

    navToRecordDefault(){
        let en=encodeDefaultFieldValues({
            FirstName:"Rejoy",
            LastName:"Kingston",
            Email:"rejoykingston@gmail.com"
        })
        this[NavigationMixin.Navigate]({
            type:"standard__objectPage",
            attributes:{
                objectApiName:"Contact",
                actionName:"new",

            },
            state:{
                defaultFieldValues:en
            }
        })
    }
    navToListView(){
        this[NavigationMixin.Navigate]({
            type:"standard__objectPage",
            attributes:{
                objectApiName:"Contact",
                actionName:"List"
            },
            state:{
                filterName:"Recent"
            }
        })
    }
}
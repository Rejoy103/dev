import { LightningElement } from 'lwc';
import {NavigationMixin} from "lightning/navigation"

export default class NavigateToHome extends NavigationMixin(LightningElement) {
    goToHome(){
        this[NavigationMixin.Navigate]({
            type:"standard__namedPage",
            attributes:{pageName:"home"}
        })
    }
    goToChatter(){
        this[NavigationMixin.Navigate]({
            type:"standard__namedPage",
            attributes:{pageName:"chatter"}
        })
    }
}
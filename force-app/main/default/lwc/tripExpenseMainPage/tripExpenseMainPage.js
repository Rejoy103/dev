import { LightningElement,track } from 'lwc';

export default class TripExpenseMainPage extends LightningElement {
    @track page=0

    get isLogin(){
        return this.page == 0
    }

    get isCreateUser(){
        return this.page == 1
    }

    handlePageChange(event){
        this.page=event.detail
        console.log(this.page)
    }
}
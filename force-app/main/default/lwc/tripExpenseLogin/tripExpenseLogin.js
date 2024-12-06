import { LightningElement } from 'lwc';

export default class TripExpenseLogin extends LightningElement {

    handlePageChange(event){
        let page=event.currentTarget.dataset.page
        console.log(page)
        const e=new CustomEvent('pagechange',{detail:page})
        this.dispatchEvent(e)
    }
}
import { LightningElement, track } from 'lwc';

export default class CustomComboTestScreen extends LightningElement {

    options=[{'label':'Option1','value':'Option1'},
             {'label':'Option2','value':'Option2'},
             {'label':'Option3','value':'Option3'}
    ]
    selected=this.options[0]

    selectedOptions={}

    handleChange(event){
        let id=event.currentTarget.dataset.id
        let value=event.detail.value
        let label=event.detail.label
        let temp=this.selectedOptions[id]
        this.selectedOptions[id]={'label':label,'value':value}
        this.options=this.options.filter( item =>{
            if(item.value == value){
                return false
            }else{
                return true
            }
        })
        if(temp != undefined){
            console.log(JSON.stringify(temp))
            this.options.push({'label':temp.label,'value':temp.value})
        }
        console.log(JSON.stringify(this.options))
    }
}
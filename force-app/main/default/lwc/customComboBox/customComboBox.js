import { LightningElement,api } from 'lwc';

export default class CustomComboBox extends LightningElement {
    @api selectedValue = {}
    @api options=[]
    @api placeholder='Select a value......'

    isDroppedDown=false


    get value(){
        if(Object.keys(this.selectedValue).length > 0){
            return this.selectedValue.label
        }else{
            return this.placeholder
        }
    }

    get menuExsist(){
        return this.options.length > 0
    }

    handleButtonClick(event){
            const element=this.template.querySelector('.dropdown-menu')
            element.classList.remove('hidden')
    }

    hideDropDown(event){
        const clicked=event.relatedTarget
        if((clicked?.classList[0] != 'dropdown-menu' || event == 'hide')){
            const element=this.template.querySelector('.dropdown-menu')
            element.classList.add('hidden')
        }
    }

    handleMenuItemClick(event){
        let data=event.currentTarget.dataset
        this.selectedValue={'label':data.label,'value':data.value}
        this.hideDropDown('hide')
        const e=new CustomEvent('selected',{
            detail:{'value':data.value,'label':data.label}
        })
        this.dispatchEvent(e)
    }

    handleBlur(event){
        console.log(event.relatedTarget)
    }
}
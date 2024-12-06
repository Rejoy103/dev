import { LightningElement } from 'lwc';
import createEntry from '@salesforce/apex/bmicontroller.createEntry';

export default class BmiCalculator extends LightningElement {
    height=''
    weight=''
    name=''
    type=''
    bmi=0
    lean=false
    healthy=false
    over=false
    obese=false
    result=document.getElementsByName("result");

    inputhandler(event){
        const {name,value}=event.target;
        if(name == 'height'){
            this.height=value;
        }else if(name == 'Name'){
            this.name=value;
        }else{
            this.weight=value;
        }
    }

    submitHandler(event){
        event.preventDefault();
        console.log('Height : '+this.height);
        console.log('Weight : '+this.weight);
        this.bmi = this.calculate();
        if(this.bmi<18.5){
            this.type='Lean'
            this.lean=true
            this.healthy=false
            this.over=false
            this.obese=false
        }else if(this.bmi > 18.5 && this.bmi <25){
            this.type='Healthy'
            this.lean=false
            this.healthy=true
            this.over=false
            this.obese=false
        }else if(this.bmi > 25 && this.bmi <30){
            this.type='Over Weight'
            this.lean=false
            this.healthy=false
            this.over=true
            this.obese=false
        }else{
            this.type='Obese'
            this.lean=false
            this.healthy=false
            this.over=false
            this.obese=true
        }
        createEntry({username:this.name,h:Number(this.height),w:Number(this.weight),b:Number(this.bmi),t:this.type}).then(res => {console.log(res)}).catch(err => {console.log('Error Occured : '+err.message)})
    }

    calculate(){
        let height=Number(this.height)/100;
        let bmi=(Number(this.weight)/(height*height));
        return Number(bmi.toFixed(2));
    }
}
import { LightningElement,track } from 'lwc';
import {countryCodeList} from 'c/countyCodeList';
import currencyConvertor from '@salesforce/resourceUrl/currencyConvertor'

export default class CurrencyConvertor extends LightningElement {
    countyCode=countryCodeList
    fromvalue=0
    tovalue=0
    selectedFrom="AED"
    selectedTo="AED"
    img=currencyConvertor+'/\currencyConverterAssets/currency.svg'
    rates={}

    connectedCallback(){
        this.convert();
    }


    handleChange(event){
       const {name,value}=event.target
       if(name == 'fromdrp'){this.selectedFrom=value;this.convert();this.calculate();}
       else {this.selectedTo=value;this.calculate();}
    }

    handleInput(event){
        const {name,value}=event.target
        console.log(name,value)
        if(name == 'fromcur')this.fromvalue=parseInt(value)
        this.calculate();
    }

    calculate(){
        let rate=this.rates[this.selectedTo]
        this.tovalue=this.fromvalue * rate
    }

    async convert(){
        const API_URL="https://api.exchangerate.host/latest?base="+this.selectedFrom
        try{
            const data=await fetch(API_URL)
            const j=await data.json()
            this.rates=j.rates
            console.log(j)
        }catch(error){
            console.log(error)
        }
    }
}
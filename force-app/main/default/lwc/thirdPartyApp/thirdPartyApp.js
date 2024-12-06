import { LightningElement } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader' 

import MOMENT from '@salesforce/resourceUrl/moment'

export default class ThirdPartyApp extends LightningElement {
    curdate
    renderedCallback(){
        Promise.all([
            loadScript(this,MOMENT+"/moment/moment.min.js")
        ]).then(()=>{
            console.log("Script loaded successfully")
            this.curdate=moment().format('LLLL')
        }).catch((error)=>{
            console.error(error)
        })
    }
}
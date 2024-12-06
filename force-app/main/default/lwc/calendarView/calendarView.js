import { LightningElement } from 'lwc';

export default class CalendarView extends LightningElement {
    curDate=new Date();
    dd=''
    mm=''
    yy=''
    today=''
    timeofday=[]
    days=['Sun','Mon','Tue','Wed','Thu','Fri','Sat']

    constructor(){
        super()
        this.dd=String(this.curDate.getDate()).padStart(2,'0')
        this.mm=String(this.curDate.getMonth()+1).padStart(2,'0')
        this.yy=String(this.curDate.getFullYear())
        for(var i=1;i<=24;i++){
            if(i<=12){
                if(i == 12){
                    this.timeofday.push("12:00 PM")
                }else{
                    this.timeofday.push(String(i).padStart(2,"0")+":00 AM")
                }
                
            }else{
                let rem=i%12
                if(rem == 0){
                    this.timeofday.push("12:00 AM")
                }else{
                    this.timeofday.push(String(rem).padStart(2,"0")+":00 PM")
                }
            }
        }
    }

    connectedCallback(){
        this.today=this.dd+'/'+this.mm+'/'+this.yy
        console.log(this.today)
    }
}
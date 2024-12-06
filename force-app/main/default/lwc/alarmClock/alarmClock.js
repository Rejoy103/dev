import { LightningElement } from 'lwc';
import clockAsset from '@salesforce/resourceUrl/clockasset'

export default class AlarmClock extends LightningElement {
    clockimage=clockAsset+'/AlarmClockAssets/clock.png'
    ringtone=new Audio(clockAsset+'/AlarmClockAssets/Clocksound.mp3')
    currentTime=""
    shour=""
    sminute=""
    sampm=""
    alarmSet=false
    setTime=""
    get isSelected(){
        return !(this.shour != "" && this.sminute != "" && this.sampm != "")
    }
    connectedCallback(){
        this.currentTimeHandler();
    }


    inputHandler(event){
        if(event.target.name == 'hour'){
            if(event.target.value <10){
                this.shour="0"+event.target.value
            }else{
                this.shour=String(event.target.value)
            }
        }else if (event.target.name == 'minute'){
            if(event.target.value <10){
                this.sminute="0"+event.target.value
            }else{
                this.sminute=String(event.target.value)
            }
        }else if (event.target.name == 'ampm'){
            this.sampm=event.target.value
            console.log(event.target.value)
        }
        console.log(this.shour + ' : ' + this.sminute + ' '+ this.sampm)
    }

    btnHandler(event){
        this.alarmSet=true
        this.setTime=`${this.shour}:${this.sminute} ${this.sampm.toUpperCase()}`
    }

    clearHandler(event){
        this.alarmSet=false
        this.setTime=""
        this.shour=""
        this.sminute=""
        this.sampm=""
        this.template.querySelector('img').classList.remove('shake')
        this.ringtone.pause()
    }
    
    currentTimeHandler(){
        setInterval(() => {
            let datetime =new Date()
            let hour=datetime.getHours()
            let min=datetime.getMinutes()
            let sec=datetime.getSeconds()
            let ampm="AM"
            if(hour==0){
             hour=12
             ampm="AM"
            }else if(hour ==12){
             ampm="PM"
            }else if(hour > 12){
             hour=hour-12
             ampm="PM"
            }
            hour=hour<10?"0"+hour:hour
            min=min<10?"0"+min:min
            sec=sec<10?"0"+sec:sec
     
            this.currentTime=`${hour}:${min}:${sec} ${ampm}`
            if(this.alarmSet){
                let checkTime=`${hour}:${min} ${ampm}`
                if(checkTime == this.setTime){
                    this.template.querySelector('img').classList.add('shake')
                    this.ringtone.play()
                    this.ringtone.loop=true
                }
            }
        },1000)
       
    }
}
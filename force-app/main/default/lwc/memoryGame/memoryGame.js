import { LightningElement } from 'lwc';
import {loadStyle} from 'lightning/platformResourceLoader';
import FONTAWESOME from '@salesforce/resourceUrl/Fontawesome';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class MemoryGame extends LightningElement {
    isLibLoaded=false;
    openedcards=[];
    matchedcard=[];
    timeRef
    rate
    isWon=false;
    time="0:0"
    moves=0;
    cards=[
        {id:1,listClass:"card",type:"diamond",icon:"fa fa-solid fa-diamond"},
        {id:2,listClass:"card",type:"diamond",icon:"fa fa-solid fa-diamond"},
        {id:3,listClass:"card",type:"heart",icon:"fa fa-solid fa-heart"},
        {id:4,listClass:"card",type:"heart",icon:"fa fa-solid fa-heart"},
        {id:5,listClass:"card",type:"key",icon:"fa fa-solid fa-key"},
        {id:6,listClass:"card",type:"key",icon:"fa fa-solid fa-key"},
        {id:7,listClass:"card",type:"car",icon:"fa fa-solid fa-car"},
        {id:8,listClass:"card",type:"car",icon:"fa fa-solid fa-car"},
        {id:9,listClass:"card",type:"lock",icon:"fa fa-solid fa-lock"},
        {id:10,listClass:"card",type:"lock",icon:"fa fa-solid fa-lock"},
        {id:11,listClass:"card",type:"trash",icon:"fa fa-solid fa-trash"},
        {id:12,listClass:"card",type:"trash",icon:"fa fa-solid fa-trash"},
        {id:13,listClass:"card",type:"tree",icon:"fa fa-solid fa-tree"},
        {id:14,listClass:"card",type:"tree",icon:"fa fa-solid fa-tree"},
        {id:15,listClass:"card",type:"trophy",icon:"fa fa-solid fa-trophy"},
        {id:16,listClass:"card",type:"trophy",icon:"fa fa-solid fa-trophy"}
    ];

    connectedCallback(){
    this.randomize();
    }

    renderedCallback(){
        if(this.isLibLoaded == false){
            loadStyle(this,FONTAWESOME+'/fontawesome/css/font-awesome.min.css').then(()=>{console.log('Font Awesome Loaded Successfully')}).catch(error=>{console.error(error)});
            this.isLibLoaded=true;
        }
    }

    displayCard(event){
        let cur=event.target;
        cur.classList.add("open","show","disabled");
        this.openedcards=this.openedcards.concat(event.target);
        const len=this.openedcards.length;
        if(len===2){
            this.moves+=1;
            if(this.moves==1){
                this.timer();
            }
            if(this.openedcards[0].type==this.openedcards[1].type){
                this.matched();
            }else{
                console.log("Not match");
                this.unmatched();
            }
        }
    }

    matched(){
        this.matchedcard=this.matchedcard.concat(this.openedcards);
        this.openedcards[0].classList.add("match");
        this.openedcards[1].classList.add("match");
        this.openedcards[0].classList.remove("show","open");
        this.openedcards[1].classList.remove("show","open");
        this.openedcards=[];
        if(this.matchedcard.length == 16){
            window.clearInterval(this.timeRef);
            this.isWon=true;
        }
    }

    unmatched(){
        console.log("in");
        this.openedcards[0].classList.add("unmatched");
        this.openedcards[1].classList.add("unmatched");
        this.action("DISABLE");
        setTimeout(()=>{
            this.openedcards[0].classList.remove("show","open","unmatched");
            this.openedcards[1].classList.remove("show","open","unmatched");
            this.action("ENABLE");
            this.openedcards=[];
        },1100);

    }

    action(action){
        let ele=this.template.querySelectorAll(".card");
        Array.from(ele).forEach(item=>{
            if(action=="ENABLE" && !item.classList.contains("match")){
                item.classList.remove("disabled")
            }else if(action=="DISABLE"){
                item.classList.add("disabled");
            }
        })
    }

    timer(){
        let starttime= new Date();
        this.timeRef=setInterval(()=>{
            let diff=new Date().getTime() - starttime.getTime();
            let d=Math.floor(diff/1000);
            const m=Math.floor(d%3600/60);
            const s=Math.floor(d%3600%60);
            const mDisplay =m>0 ? m+(m==1 ? " minute" : " minutes"):"";
            const sDisplay=s>0 ?s+(s==1 ? " second" : " seconds"):"";
            this.time=mDisplay+sDisplay;
        },1000);
    }

    reset(){
        this.openedcards=[];
        this.matchedcard=[];
        this.time="0:0";
        this.moves=0;
        window.clearInterval(this.timeRef);
        this.isWon=false;
        let ele=this.template.querySelectorAll(".card");
        Array.from(ele).forEach(item=>{
            item.classList.remove("show","open","disabled","match");
        });
        this.randomize();
    }
    randomize(){
        let count=0;
        let len=this.cards.length;
        while(count!=len){
            let ran=Math.floor(Math.random()*len);
            let temp=this.cards[ran];
            this.cards[ran]=this.cards[count];
            this.cards[count]=temp;
            count+=1;
        }
    }
}
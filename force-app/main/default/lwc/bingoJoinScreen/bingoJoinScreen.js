import { LightningElement,track } from 'lwc';
import getLobby from '@salesforce/apex/bingo_GetLobbyByName.getLobby'
import NumberOfFailedLogins from '@salesforce/schema/User.NumberOfFailedLogins';
import {createRecord} from 'lightning/uiRecordApi';

import USERNAME from '@salesforce/schema/Player__c.Username__c'
import LOBBYREF from '@salesforce/schema/Player__c.Lobby__c'
import HOST from '@salesforce/schema/Player__c.isHost__c'

export default class BingoJoinScreen extends LightningElement {
    lobby=[]
    @track loading=false
    username=''
    playerid=''

    connectedCallback(){
        this.getLobbys();
    }

    disconnectedCallback(){
        console.log('Join - disconnected')
    }

    async getLobbys(){
        this.loading=true
        setTimeout(c =>{},5000);
        await getLobby().then(result => {
            this.lobby=result;
        })
        this.loading=false
        
    }

    handleTextChange(e){
        const {name,value} =e.target;
        this.username=value
    }

    handleBack(){
        const backevent=new CustomEvent('back',{
            detail:'join'
        });
        this.dispatchEvent(backevent);
    }

    handleJoin(event){
        const {name,value} = event.target;
            const btn=this.template.querySelector('button[name="'+name+'"]');
            btn.disabled=true;
            console.log('Name : '+ name);
            console.log('Value :' + value);
            if(this.username == ''){
                console.log('Username required')
                btn.disabled=false;
            }else{
                this.createPlayer(name);
            }
    }

    async createPlayer(id){
        this.loading=true
        let fields2={}
        fields2[LOBBYREF.fieldApiName]=id
        fields2[USERNAME.fieldApiName]=this.username
        fields2[HOST.fieldApiName]=false
        const recordInput = {
            apiName: 'Player__c',
            fields: fields2
            };
            await createRecord(recordInput).then((record) =>{
            this.playerid=record.id;
            const mainScreen=new CustomEvent('lobbycreated',{detail:{status:'lobby',recid:id,username:this.username,playerid:this.playerid,ishost:false}})
            this.dispatchEvent(mainScreen);
        }).catch(error => {
            console.log(error)
        })
        this.loading=false
    }
}
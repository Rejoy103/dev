import { LightningElement } from 'lwc';
import { createRecord } from "lightning/uiRecordApi";
import isLobbyThere from '@salesforce/apex/bingo_GetLobbyByName.isLobbyExist';
import LOBBY_OBJECT from '@salesforce/schema/Lobby__c'
import NAME from '@salesforce/schema/Lobby__c.Name__c'
import MAX_PLAYER from '@salesforce/schema/Lobby__c.Max_Player__c'
import USERNAME from '@salesforce/schema/Player__c.Username__c'
import LOBBYREF from '@salesforce/schema/Player__c.Lobby__c'
import HOST from '@salesforce/schema/Player__c.isHost__c'

export default class BingoHostScreen extends LightningElement {
    username=''
    lobbyname=''
    maxplayer=2
    alreadyExist=false
    lobbyid=''
    loading=false
    playerid=''
    
    async handleSubmit(event){
        event.preventDefault();
        this.createLobby();
    }

    async createLobby(){
        const btn=this.template.querySelector('.btn_submit');
        btn.disabled=true
        this.loading=true
        await isLobbyThere({Name:this.lobbyname}).then(result => {
            this.alreadyExist=result;
        }).catch(error => {
            console.log(error);
        })
        if(!this.alreadyExist){
            try{
                let fields1={}
                fields1[NAME.fieldApiName]=this.lobbyname
                fields1[MAX_PLAYER.fieldApiName]=this.maxplayer
                let recordInput = {
                    apiName: LOBBY_OBJECT.objectApiName,
                    fields: fields1
                  };
                  console.log(recordInput)
                await createRecord(recordInput).then((record) =>{
                    this.lobbyid=record.id
                    console.log('Lobby Id : '+this.lobbyid)
                }).catch(err => {
                    console.log('Error : '+err.message)
                })
            }catch(ex){
                console.log('error - ' + ex.message)
            }
            try{
                let fields2={}
                fields2[LOBBYREF.fieldApiName]=this.lobbyid
                fields2[USERNAME.fieldApiName]=this.username
                fields2[HOST.fieldApiName]=true
                const recordInput = {
                    apiName: 'Player__c',
                    fields: fields2
                  };
                    await createRecord(recordInput).then((record) =>{
                    this.playerid=record.id
                }).catch(error => {
                    console.log(error)
                })
            }catch(ex){
                console.log('Player insert Error - ' + ex.message)
            }
            this.loading=false
            const ctop=new CustomEvent('lobbycreated',{
                detail:{status:'lobby',recid:this.lobbyid,username:this.username,playerid:this.playerid,ishost:true}
            })
            this.dispatchEvent(ctop);
        }else{
            btn.disabled=false
            this.loading=false
            console.log('Already there')
        }
    }

    handleBack(){
        const backevent=new CustomEvent('back',{
            detail:'join'
        });
        this.dispatchEvent(backevent);
    }

    handleTextChange(event){
        const {name,value}=event.target;
        if( name == 'username')this.username=value
        else if(name == 'lobbyname')this.lobbyname=value
        else if(name == 'maxplayer')this.maxplayer=parseInt(value)
    }
}
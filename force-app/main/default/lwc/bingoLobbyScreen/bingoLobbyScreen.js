import { LightningElement,api,track } from 'lwc';
import getLobby from '@salesforce/apex/bingo_GetLobbyByName.getLobbyById';
import getPlayer from '@salesforce/apex/bingo_GetLobbyByName.getPlayerByLobbyId';
import { subscribe,unsubscribe,onError,isEmpEnabled} from 'lightning/empApi';
import { deleteRecord } from 'lightning/uiRecordApi';

export default class BingoLobbyScreen extends LightningElement {
    @api lobbyid;
    @api username;
    @api playerid;
    @api ishost=false;
    @track LobbyName=''
    @track maxplayer=0
    @track totalplayer=0
    lobbysubscribed=false
    playersubscribed=false
    lobbyChangeEvent='/data/Lobby__ChangeEvent'
    playerChangeEvent='/data/Player__ChangeEvent'
    lobbysub={}
    playersub={}
    players=[]

    connectedCallback(){
        this.getLobbyInfo()
        console.log(isEmpEnabled)
        if(!isEmpEnabled){
            console.log('EMP not supported')
        }
        this.handleLobbySubscribe();
        //this.handlePlayerSubscribe();
        this.registerErrorListener();
    }

    disconnectedCallback(){
        this.handleUnSubscribe();
    }

    handleLobbySubscribe(){
        if(!this.lobbysubscribed){
            const mcallback= (response) => {
                this.handleLobbyResponse(response);
            }
            console.log('Inside Lobby Screen - Lobby Sub')
                subscribe('/data/Lobby__ChangeEvent',-1,mcallback).then( (response)  => {
                    console.log('inside sub')
                    this.lobbysub=response ;
                    this.lobbysubscribed=true
                    console.log('Lobby Screen - Lobby Sub successfully')
                }).catch(err => {
                    console.log(err)
                })
                console.log('Inside Lobby Screen - Lobby End')

        }
    }

    registerErrorListener() {
        // Invoke onError empApi method
        onError((error) => {
            console.log('Received error from server: ', JSON.stringify(error));
            // Error contains the server-side error
        });
    }

    handlePlayerSubscribe(){
        if(!this.playersubscribed){
            const mcallback= (response) => {
                this.handlePlayerResponse(response);
            }
            subscribe(this.playerChangeEvent,-1,mcallback).then( response  => {
                this.playersub=response ;
                this.playersubscribed=true 
                console.log('Lobby screen - Player sub sucessful')
            }).catch(err => {
                console.log(err);
            })
          
        }
    }

    handleUnSubscribe(){
        if(this.lobbysubscribed){
            unsubscribe(this.lobbysub, (res) => {
                console.log('Lobby Unsubcribed')
            })
        }
        if(this.playersubscribed){
            unsubscribe(this.playersub, (res) => {
                console.log('Player Unsubcribed')
            })
        }
    }

    handleLobbyResponse(res){
        console.log(JSON.stringify(res))
        if(res.hasOwnProperty('data')){
            let responsePayload = response.data.payload;

        }
    }

    handlePlayerResponse(res){

    }

    handleLeave(event){
        if(this.ishost){
            deleteRecord(this.lobbyid).then(res => {
                const e=new CustomEvent('lobbycreated',{detail:{status:'mainscreen',recid:'',username:'',playerid:'',ishost:false}})
                this.dispatchEvent(e);
            }).catch(err => {
                console.log(err.body.message)
            })
        }else{
            deleteRecord(this.playerid).then(res => {
                const e=new CustomEvent('lobbycreated',{detail:{status:'mainscreen',recid:'',username:'',playerid:'',ishost:false}})
                this.dispatchEvent(e);
            })
        }
    }

    async getLobbyInfo(){
        await getLobby({lid:this.lobbyid}).then(result => {
            this.LobbyName=result.Name__c;
            this.maxplayer=parseInt(result.Max_Player__c);
            this.totalplayer=parseInt(result.Total_Player__c);
            console.log(result)
        }).catch(ex => {
            console.log('Lobby Info Error - '+ex.message);
        })
        await getPlayer({lid:this.lobbyid}).then(result => {
            this.players=result;
        }).catch(ex => {
            console.log(ex.message);
        })
    }
}
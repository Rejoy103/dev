import { LightningElement } from 'lwc';

export default class BingoMainScreen extends LightningElement {
    mainScreen=true
    HostScreen=false
    JoinScreen=false
    LobbyScreen=false
    lobbyid=''
    username=''
    playerid=''
    isHost=false

    handleHost(event){
        const {name,value}=event.target;
        switch(name){
            case 'host':
                this.mainScreen=false;
                this.HostScreen=true;
                this.JoinScreen=false;
                this.LobbyScreen=false;
                break;
            case 'join':
                this.mainScreen=false;
                this.HostScreen=false;
                this.JoinScreen=true;
                this.LobbyScreen=false;
                break;
            default:
                this.mainScreen=true;
                this.HostScreen=false;
                this.JoinScreen=false;
                this.LobbyScreen=false;
        }
    }

    handleBack(event){
        this.mainScreen=true
        this.HostScreen=false
        this.JoinScreen=false
        this.LobbyScreen=false
    }


    handleChildEvent(event){
        console.log('Inside parent')
        this.lobbyid=event.detail.recid;
        this.username=event.detail.username;
        this.playerid=event.detail.playerid;
        this.isHost=event.detail.ishost;
        console.log('Main Screen - PLayer Id '+this.playerid)
        console.log('Main Screen - username '+this.username)
        console.log('Main Screen - ishost '+event.detail.ishost)
        switch(event.detail.status){
            case 'lobby':
                this.mainScreen=false
                this.HostScreen=false
                this.JoinScreen=false
                this.LobbyScreen=true
                break;
            case 'mainscreen':
                this.mainScreen=true
                this.HostScreen=false
                this.JoinScreen=false
                this.LobbyScreen=false
                break;
        }
    }
}
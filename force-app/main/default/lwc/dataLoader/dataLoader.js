import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DataLoader extends LightningElement {
    @api title;
    @api verified=false;
    @api recordId;
    file
    filename='No files uploaded'
    filecheck=false
    loading=false
    home=true
    userinfoscreen=false
    invaliddatapresent=false
    @api tosalesforce=null
    columns=null
    validHeader=['Salutation','FirstName','LastName','Email','Phone']
    invalidHeader=[]
    invaliddata=[]

    totalrecords=0
    validrecords=0
    invalidrecords=0

    handleFile(event){
        try{
            const files=event.detail.files;
            console.log(files[0])
            if(files.length > 0){this.file=files[0];this.filename=files[0].name}
            this.verifyFile()
            this.verified=true;
        }catch(e){
            console.error(e)
        }
        
    }

    verifyFile(){
        this.home=false
        if(this.file == undefined){
            this.home=true
            console.log(this.file)
            this.toastError('Info','Please select a file','info')
        }else{
            this.load(this.file);
        }
        
    }

    toastError(t,m,v){
        const evt = new ShowToastEvent({
            title: t,
            message: m,
            variant: v,
        });
        this.dispatchEvent(evt);
    }

    async load(f){
        try{
            this.loading=true
            const result = await this.read(f);
            const res=await this.parse(result);
            this.loading=false
            if(res){
                this.validrecords=this.tosalesforce.length
                this.invalidrecords=this.invaliddata.length == null ?0:this.invaliddata.length
                this.totalrecords=this.validrecords+this.invalidrecords
                this.userinfoscreen=true
                this.invaliddatapresent=(this.invaliddata.length >0 )
            }else{
                this.home=true
            }
        }catch(e){
            console.error(e)
            this.toastError('Error',e,'error')
        }
    }

    async read(f){
        return new Promise((resolve,reject) => {
            const fr= new FileReader();
            fr.onload = () => {
                resolve(fr.result)
            }

            fr.onerror = () => {
                reject(fr.error)
            }

            fr.readAsText(f)
        })
        

    }

    parse(data){
        const lines= data.split(/\r\n|\n/);
        const header=lines[0].split(',')
        const res=this.validateHeader(header);
        if(!res){
            this.toastError('Error','Invalid headers : '+this.invalidHeader.join(' '),'error')
            console.log(this.invalidHeader)
            return false;
        }
        const datas=[]
        const invaliddata=[]
        const emailno=header.findIndex(this.getEmailIndex);
        console.log('Email Header : '+emailno)
        this.columns=header.map((h) => {
            return {label:h,fieldName:h};
        })
        lines.forEach((ele,i) => {
            if( i == 0)return;
            const obj = {};
            const curline=ele.split(',')
            for(let j=0;j<header.length;j++){
                obj[header[j]]=curline[j]
            }
            obj['AccountId']=this.recordId
            if(curline[emailno] == ''){
                invaliddata.push(obj);
            }else{
                datas.push(obj);
            }
            
        });
        this.tosalesforce=datas;
        this.invaliddata=invaliddata;
        console.log('Verified Data : ')
        console.log(this.tosalesforce)
        console.log('Invalid Data : ')
        console.log(this.invaliddata)
        return true;
    }

    getEmailIndex(email) {
        return email == 'Email';
      }

     validateHeader(h){
        h.forEach((data,i)=>{
            if(!this.validHeader.includes(data)){
                this.invalidHeader.push(data);
            }
        })
        console.log('Invalid Header')
        console.log(this.invalidHeader)
        if(this.invalidHeader.length>0){
            return false
        }else{
            return true
        }
    }
}
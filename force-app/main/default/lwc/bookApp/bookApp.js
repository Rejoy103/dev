import { LightningElement } from 'lwc';
const URL='https://www.googleapis.com/books/v1/volumes?q='

export default class BookApp extends LightningElement {
    query='man'
    books
    timeout
    connectedCallback(){
        this.fetchData();
    }

    fetchData(){
        fetch(URL+this.query).then(res=>res.json()).then(data=>{console.log(data);this.books=data;}).catch(error=>console.error(error));

    }

    onChangeHandler(event){
        this.query=event.target.value;
        window.clearInterval(this.timeout);
        this.timeout=setTimeout(()=>{
            console.log(this.query);
            this.fetchData();
        },1000);
    }
}
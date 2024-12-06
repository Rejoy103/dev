import { LightningElement } from 'lwc';
import checkUserExsist from '@salesforce/apex/TripDairy_Login_Helper.checkUserNameExsist'

export default class TripExpenseCreateUser extends LightningElement {

    firstName=""
    lastName=""
    email=""
    password=""
    username=""
    confirmPassword=""

    handleCreate(event){
        let test=this.validate()
        checkUserExsist({data:JSON.stringify({'userName':this.username,'email':this.email})}).then(result=>{
            if(result){
                alert("Already user with this username or email exsist")
            }else{
                alert("No user exsist")
            }
        })
    }

    validate(){
        if(this.firstName=="" || this.lastName=="" || this.email=="" || this.username=="" || this.password=="" || this.confirmPassword==""){
            alert("Please fill all fields")
            return false
        }else if(this.password != this.confirmPassword){
            alert("Password and confirm password does not match")
            return false
        }else{
            return true
        }
    }

    handleChange(event){
        let t=event.currentTarget.dataset.id
        switch(t){
            case "0":
                this.firstName=event.target.value
                break;
            case "1":
                this.lastName=event.target.value
                break;
            case "2":
                this.email=event.target.value
                break;
            case "3":
                this.username=event.target.value
                break;
            case "4":
                this.password=event.target.value
                break;
            case "5":
                this.confirmPassword=event.target.value
                break;
        }
        console.log(this.firstName)
    }
}
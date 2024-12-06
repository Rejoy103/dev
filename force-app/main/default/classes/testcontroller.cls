public class testcontroller {
    public list<Account> acc{get;set;}
    Public String accid{get;set;}
    public String name{get;set;}
    public Boolean isOk{get;set;}
    public id acccid{get;set;}

    public testcontroller(){
        acc=[select Id,Name From Account];
        if(acc != null){
            isOk=true;
            acccid = Apexpages.currentPage().getParameters().get('Id');
        }
        else isOk=false;
        system.debug(acc);
    }
    public List<SelectOption> getOptions(){
        List<SelectOption> op=new List<SelectOption>();
        for(Account a :acc){
            op.add(new SelectOption(a.Id,a.Name));
        }
        return op;
    }
    public void change(){
        System.debug(this.accid);
        this.name=this.accid;
    }
}
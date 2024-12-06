public class Test {
    public void run(){
        	Account a= [select Id,Name,(Select Id from Contacts) from Account where Id='0015j00000Wz96vAAB'][0];
            Account b=a.clone(false,false,false,false);
            b.Name='Rejoy Comp2';
            Delete a;
            insert b;
    }

}
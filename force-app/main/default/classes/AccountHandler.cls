public class AccountHandler{
    public static void insertAccount(Integer x){
        List<Account> addAccounts=new List<Account>();
        Integer n=1;
        while(n<=x){
            Account temp=new Account();
            temp.Name='Acme Inc '+n;
            temp.AccountNumber='A000'+n;
            addAccounts.add(temp);
            n++;
        }
        insert addAccounts;
    }
}
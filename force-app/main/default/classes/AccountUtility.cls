public class AccountUtility {
    public static void viewAnnualRevenue(){
        list<Account> accountsList=new list<Account>();
        accountsList=[SELECT Name,AnnualRevenue FROM Account];
        string acctRev;
        for(Account i : accountsList){
            acctRev+=i.Name + ' : '+i.AnnualRevenue;
        }
        System.debug(acctRev);
    }
}
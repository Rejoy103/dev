public class triggerTest {
    public static void TestAccount(List<Account> x){
        Account a=[SELECT id FROM Account limit 1];
        system.debug('Size : '+x.size());
    }
}
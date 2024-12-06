public class Active_Estimation {
	@InvocableMethod(Label='Update Estimation on Active Account')
    public static void Activate(List<Account> x){
        for(Account i:x){
            i.addError('This Account cant be Activated. One of the Estimate has a duplicate ID');
        }
    }
}
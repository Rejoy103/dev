public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer n,String l){
        List<Contact> c=new List<Contact>();
        for(Integer i=0;i<n;i++){
            c.add(new Contact(firstname='Test'+i,lastname=l));
        }
        return c;
    }
}
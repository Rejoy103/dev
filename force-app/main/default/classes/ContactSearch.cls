public class ContactSearch {
    public static list<Contact> searchForContacts(String x,String y){
        list<Contact> z=new list<Contact>();
        z=[SELECT ID,Name FROM Contact WHERE LastName=:x AND MailingPostalCode=:y];
        return z;
    }
        
}
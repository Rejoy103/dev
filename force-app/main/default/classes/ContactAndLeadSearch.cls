public class ContactAndLeadSearch {
    public static list<list<SObject>> searchContactsAndLeads(String x){
        list<list<SObject>> y=[FIND :x IN NAME FIELDS RETURNING Contact(Name),Lead(Name)];
        return y;
    }
}
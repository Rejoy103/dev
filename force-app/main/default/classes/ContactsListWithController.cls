public class ContactsListWithController {
    private String sortOrder='FirstName';
    private String ord ='Asc';
	public List<Contact> getContacts() {
    	List<Contact> results = Database.query(
        'SELECT Id, FirstName, LastName, Title, Email ' +
        'FROM Contact ' +
        'ORDER BY ' + sortOrder + 'Asc' +
        'LIMIT 10'
    );
    return results;
  }      
    public void sortByFirstName(){
        this.sortOrder='FirstName';
    }
    public void sortByLastName(){
        this.sortOrder='LastName';
    }
}
public class ContactsControllerExtension {
    
    private ApexPages.StandardSetController contactsController{get;set;}
    private String individualId{get;set;}
    
    
    public ContactsControllerExtension(ApexPages.StandardSetController ssc) {
        this.contactsController = ssc;
    }
    
    public PageReference createContact() {
        return Page.createContact;
    }
    
    public PageReference deleteContact() {
        try {
            Contact contactById = new Contact(Id=individualId);
            delete contactById;
            return null;
        } catch (DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
	}
}
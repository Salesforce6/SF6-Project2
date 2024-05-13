public class createContactExtension {
    private ApexPages.StandardController contactController{get;set;}
    private Contact newContact;
    
    public createContactExtension(ApexPages.StandardController sc) {
        this.contactController = sc;
        this.newContact = (Contact)sc.getRecord();
    }
    
    public PageReference saveandRedirect() {
		try {
            newContact.Phone = '5555555555';
            upsert newContact;
            return Page.ContactsTable;
        } catch (DmlException de) {
            ApexPages.addMessages(de);
            return null;
        }
    }
    
    public PageReference cancel() {
        return Page.ContactsTable;
    }

    
    

}
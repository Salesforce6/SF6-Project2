public class createLeadExtension {
    
    private ApexPages.StandardController createLeadController{get;set;}
    private Lead newLead;
    
    public createLeadExtension(ApexPages.StandardController sc) {
        this.createLeadController = sc;
        this.newLead = (Lead)sc.getRecord();
        
    }
    
    public PageReference saveandRedirect() {
		try {
            upsert newLead;
            return Page.LeadsTable;
        } catch (DmlException de) {
            ApexPages.addMessages(de);
            return null;
        }
    }
    
    public PageReference cancel() {
        return Page.LeadsTable;
    }

}
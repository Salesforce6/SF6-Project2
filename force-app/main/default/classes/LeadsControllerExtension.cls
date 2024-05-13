public class LeadsControllerExtension {
    
    private ApexPages.StandardSetController leadsController{get;set;}
    public String leadId{get;set;}
    
    public LeadsControllerExtension(ApexPages.StandardSetController ssc) {
        this.leadsController = ssc;
    }
    
    public PageReference createLead() {
        return Page.createLead;
    }
    
    public PageReference deleteLead() {
        try {
            Lead leadById = new Lead(Id=leadId);
            delete leadById;
            return null;
        } catch (DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
	}
}
public with sharing class OpportunityRecordExtensions {

    private Opportunity Opp;
    public String OpportunityId{get;set;}
    private PageReference oppRedirectTable = Page.vfOpportunityTable;
    private PageReference oppRedirectRecord = Page.vfOpportunityRecord;

    public OpportunityRecordExtensions(ApexPages.StandardController sc) {
        if (sc != NULL) {
            this.Opp = (Opportunity)sc.getRecord();
        }
    }
    public OpportunityRecordExtensions(ApexPages.StandardSetController sc) {
        if (sc != NULL) {
            this.Opp = (Opportunity)sc.getRecord();
        }
    }

    public PageReference createRecord(){
        oppRedirectRecord.setRedirect(true);
        return oppRedirectRecord;
    }

    public PageReference  cancelRecord(){
        oppRedirectTable.setRedirect(true);
        return oppRedirectTable;
    }

    public PageReference saveRecord(){
        try {
            upsert Opp;
            oppRedirectTable.setRedirect(true);
            return oppRedirectTable;
        } catch (DmlException de) {
            ApexPages.addMessages(de);
            return null;
        }
    }

    public PageReference deleteRecord(){
        try {
            Opportunity oppDel = new Opportunity(Id = OpportunityId);
            delete oppDel;
            oppRedirectTable.setRedirect(true);
            return oppRedirectTable;

        } catch (Exception ex) {
         ApexPages.addMessages(ex);
         return null;
        }
    }
}
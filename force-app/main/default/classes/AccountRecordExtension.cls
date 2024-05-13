public with sharing class AccountRecordExtension {

    private Account acc;
    public String AccountId{get;set;}

    private PageReference accTable = Page.AccountTable;

    public AccountRecordExtension(ApexPages.StandardSetController ssc) {
        this.acc = (Account)ssc.getRecord();
    }
}
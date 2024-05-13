public class AccountControllerExtension {
    
    private ApexPages.StandardSetController accountSetController {get; set;}
    public String accountId{get;set;}
    
    public AccountControllerExtension(ApexPages.StandardSetController ssc) {
        accountSetController = ssc;
        accountSetController.setPageSize(20);
    }
    
    public PageReference createAccount() {
        return Page.createAccount;
    }
    
    public PageReference deleteAccount() {
        try {
            Account accById = new Account(Id=accountId);
            delete accById;
            return null;
        } catch (DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
	}
}
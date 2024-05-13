public class createAccountExtension {
    
    private ApexPages.StandardController accountController {get; set;}
    private Account newAccount;
    
    public createAccountExtension(ApexPages.StandardController sc) {
        
        this.accountController = sc;
        this.newAccount = (Account)accountController.getRecord();
    }
    
    public Account getNewAccount() {
        return newAccount;
    }

    public void setNewAccount(Account acc) {
        newAccount = acc;
    }
    
    public PageReference saveandRedirect() {
		try {
            newAccount.Phone = '5555555555';
            upsert newAccount;
            return Page.AccountTable;
        } catch (DmlException de) {
            ApexPages.addMessages(de);
            return null;
        }
    }
    
    public PageReference cancel() {
        return Page.AccountTable;
    }
}
public with sharing class OrderController {

    public ID OrderID{get; set;}
    private Order Ord = new Order();

    public OrderController(ApexPages.StandardSetController ssc) {
        this.Ord = (Order)ssc.getRecord();
    }
    public OrderController(ApexPages.StandardController sc) {
        this.Ord = (Order)sc.getRecord();
    }

    public PageReference goToOrder() {
        PageReference Pr = Page.vfOrderRecordPage;
        Pr.getParameters().put('id', this.OrderId);
        return pr.setRedirect(true);
    }

    public PageReference cancelInsert() {
        return Page.vfOrderTable.setRedirect(true);
    }

    public PageReference saveOrder() {
        try {
            upsert this.Ord;
            return Page.vfOrderTable.setRedirect(true);
        } catch(DmlException de) {
            ApexPages.addMessages(de);
            return null;
        }
    }

    public PageReference deleteOrder() {
        try{
            Ord.Id = OrderID;
            delete Ord;
            return Page.vfOrderTable.setRedirect(true);
        } catch(Exception e) {
            ApexPages.addMessages(e);
            return null;
        }
    }

    public PageReference createOrder() {
        return Page.vfOrderRecordPage.setRedirect(true);
    }
}
public with sharing class OrderProductExtension {

    public ID OrdProdId{get; set;}
    public ID OrdId{get; set;}
    public OrderItem OrdProduct {get; set;}
    private OrderItem OrdProd = new OrderItem();
    private Order Ord2 = new Order();
    private PageReference OrdProdRecord = Page.vfOrderProductRelatedRecord;
    private PageReference OrdRecord = Page.vfOrderRecordPage;

    public OrderProductExtension(ApexPages.StandardSetController ssc) {
        try{
            this.OrdProd = (OrderItem)ssc.getRecord();
            this.OrdProd.OrderId = this.OrdId;
        } catch (Exception e) {
            this.Ord2 = (Order)ssc.getRecord();
        }
    }
    public OrderProductExtension(ApexPages.StandardController sc) {
        try {
            this.OrdProd = (OrderItem)sc.getRecord();
        } catch (Exception e) {
            this.Ord2 = (Order)sc.getRecord();
        }
    }

    public PageReference goToOrdProd() {
        OrdProdRecord.getParameters().put('id', this.OrdProdId);
        return OrdProdRecord.setRedirect(true);
    }

    public PageReference addOrdProd() {
        OrdProdRecord.getParameters().put('test', this.OrdProdId);
        return OrdProdRecord.setRedirect(true);
    }

    public PageReference updateOrdProd() {
        try {
            upsert this.OrdProd;
            OrdRecord.getParameters().put('id', this.OrdProd.OrderId);
            return OrdRecord.setRedirect(true);
        } catch (DmlException de) {
            ApexPages.addMessages(de);
            return null;
        }
    }

    public PageReference saveOrdProd() {
        try {
            Order OriginalOrder = [SELECT Id, PriceBook2Id FROM Order WHERE Id = '801aj00000GtlSGAAZ'];
            Pricebook2 Pb = [SELECT Id FROM Pricebook2 WHERE Id = :OriginalOrder.Pricebook2Id];
            PricebookEntry PbE = [SELECT Product2Id, UnitPrice, Pricebook2Id FROM PricebookEntry WHERE Product2Id = :OrdProd.Product2Id AND Pricebook2Id = :Pb.Id];
            this.OrdProd.PricebookEntryId = Pbe.Id;
            this.OrdProd.ListPrice = PbE.UnitPrice;
            this.OrdProd.UnitPrice = PbE.UnitPrice;
            this.OrdProd.OrderId = OriginalOrder.Id;
            upsert this.OrdProd;
            OrdRecord.getParameters().put('id', this.OrdProd.OrderId);
            return OrdRecord.setRedirect(true);
        } catch (DmlException de) {
            ApexPages.addMessages(de);
            return null;
        }
    }

    public PageReference cancelOrdProd() {
        OrdRecord.getParameters().put('id', this.OrdProd.OrderId);
        return OrdRecord.setRedirect(true);
    }

    public PageReference removeOrdProd() {
        try {
            OrderItem[] OrderProds = this.Ord2.OrderItems;
            Integer index = 0;
            for (Integer i = 0; i < OrderProds.size(); i++) {
                if (OrderProds[i].Id == this.OrdProdId) {
                    index = i;
                }
            }
            delete OrderProds[index];
            OrdRecord.getParameters().put('id', this.Ord2.Id);
            return OrdRecord.setRedirect(true);
        } catch (Exception e) {
            ApexPages.addMessages(e);
            return null;
        }
    }
}
@isTest
private class OpportunityRecordExtensionsTest {

    @TestSetup
    static void makeData(){
        List<Opportunity> mockOppList = new List<Opportunity>();
        for (Integer i = 0; i < 20; i++) {
            Opportunity opp = new Opportunity();

            opp.Name = 'OpportunityTest' + i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            mockOppList.add(opp);
        }
        insert mockOppList;
    }

    @isTest
    static void createRecordTest() {
        PageReference testPage = new PageReference('/apex/vfopportunityrecord');
        PageReference testNotPage = new PageReference('/apex/vfopportunityTable');

        ApexPages.StandardSetController sc;

        OpportunityRecordExtensions oppPage = new OpportunityRecordExtensions(sc);

        PageReference actualPage = oppPage.createRecord();
    
        Assert.areEqual(testPage.getURL(), actualPage.getURL());
        Assert.areNotEqual(testNotPage.getUrl(), actualPage.getURL());
    }

    @isTest
    static void cancelRecordTest(){
        PageReference testNotPage = new PageReference('/apex/vfopportunityrecord');
        PageReference testPage = new PageReference('/apex/vfopportunitytable');

        ApexPages.StandardSetController sc;

        OpportunityRecordExtensions oppPage = new OpportunityRecordExtensions(sc);

        PageReference actualPage = oppPage.cancelRecord();
    
        Assert.areEqual(testPage.getUrl(), actualPage.getURL());
        Assert.areNotEqual(testNotPage.getURL(), actualPage.getURL());
    }

    @isTest
    static void saveRecordTest(){
        Opportunity addOpp = new Opportunity();
        addOpp.Name = 'OpportunityTest21';
        addOpp.StageName = 'Prospecting';
        addOpp.CloseDate = Date.today();

        insert addOpp;

        ApexPages.StandardController sc = new ApexPages.StandardController(addOpp);
        OpportunityRecordExtensions oppPage = new OpportunityRecordExtensions(sc);
        oppPage.saveRecord();
        
        List<Opportunity> actualOpp = [SELECT Name, StageName FROM Opportunity WHERE Name = 'OpportunityTest21' LIMIT 1];

        Assert.areEqual('OpportunityTest21', actualOpp[0].Name);


        Opportunity addOpp2 = new Opportunity();

        ApexPages.StandardController sc2 = new ApexPages.StandardController(addOpp2);
        OpportunityRecordExtensions oppPage2 = new OpportunityRecordExtensions(sc2);
        PageReference actualPage = oppPage2.saveRecord();

        Assert.areEqual(null, actualPage);
    }

    @isTest
    private static void deleteRecordTest() {
      Opportunity testOpp = [SELECT Id FROM Opportunity LIMIT 1];
      PageReference pageTest = Page.vfOpportunityTable;
      Test.setCurrentPage(pageTest);
  
      ApexPages.StandardSetController sc;
      OpportunityRecordExtensions oppPage = new OpportunityRecordExtensions(sc);
      oppPage.OpportunityId = testOpp.id;
      PageReference actualPage = oppPage.deleteRecord();
  
      Opportunity expectedDeletion = [SELECT Id, IsDeleted FROM Opportunity WHERE Id = :testOpp.Id ALL ROWS];
  
      Assert.areEqual(expectedDeletion.IsDeleted, true);
      Assert.areEqual(pageTest.getURL(), actualPage.getURL());


      Opportunity testOpp2 = [SELECT Id FROM Opportunity LIMIT 1];
      ApexPages.StandardSetController sc2;
      OpportunityRecordExtensions oppPage2 = new OpportunityRecordExtensions(sc2);
      oppPage2.OpportunityId = null;
      PageReference actualPage2 = oppPage2.deleteRecord();

      Assert.areEqual(null, actualPage2);
    }
}
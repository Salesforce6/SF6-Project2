public with sharing class CaseController {
    @AuraEnabled(cacheable=true)
    public static List<Case> getCases() {
        return [SELECT CaseNumber, Priority, Account.Name, Status 
        FROM Case WHERE Priority = 'High' ORDER BY CaseNumber DESC];}
}
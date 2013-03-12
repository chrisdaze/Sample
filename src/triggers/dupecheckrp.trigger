trigger dupecheckrp on Requested_Product__c (before insert) {
    List<Requested_Product__c> rpList = new List<Requested_Product__c>();
    for(Requested_Product__c objrp : System.Trigger.new) {
        if(objrp.Request_Number__r.Status__c == 'New') {
            rpList = [SELECT Item__c FROM Requested_Product__c WHERE Request_Number__c = :objrp.Request_Number__c AND Item__c = :objrp.Item__c];
            if(rpList.size() > 0) {
                objrp.Item__c.addError('Item already exists in the request.');
            }
        } else {
            objrp.Item__c.addError('Cannot add new items to this request. Create a new Request');
        }
    }
}
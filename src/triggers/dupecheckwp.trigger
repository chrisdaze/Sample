trigger dupecheckwp on Warehouse_Product__c (before insert) {
    List<Warehouse_Product__c> wpList = new List<warehouse_Product__c>();
    for(Warehouse_Product__c objwp : System.Trigger.new) {
        wpList = [SELECT Item__c FROM Warehouse_Product__c WHERE Warehouse__c = :objwp.Warehouse__c AND Item__c = :objwp.Item__c];
            if(wpList.size() > 0) {
                objwp.Item__c.addError('Item already exists in the warehouse.');
            }
    }
}
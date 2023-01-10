/********************************************************
    @Class Name:AccountBatch
    @Author : Srinu Reddy
    @Purpose : This batch class is used to process all the account records in the system
               and appennd the account name with 'Feb 2022' and DOB as 01/01/1900   
    @CreatedDate: 25/02/2022
    *********************************************************
    @Last Modified By:
    *********************************************************/
public class AccountBatch implements Database.Batchable<sObject> {
    /********************************************************
    @Method Name:start
    @Author : Srinu Reddy
    @Purpose : Start method will return all the account records 
               to the execute method    
    *********************************************************
    @Last Modified By:
    *********************************************************/
    public Database.QueryLocator start(Database.BatchableContext bc) {
        String str = 'SELECT Id,Name,Date_of_Birth__c,Person_email__c From Account';
        return Database.getQueryLocator(str);
        
    }
    /********************************************************
    @Method Name:execute
    @Author : Srinu Reddy
    @Purpose : Execute method will update the account records   
    *********************************************************
    @Last Modified By:
    *********************************************************/
    public void execute(Database.BatchableContext bc, List<Account> records){
        system.debug('@@@records:'+records);
        List<Account> lstOfAccountsToUpdate = new List<Account>();
        /**Iterate over the account records and append the account name with Feb 2022 
        and assign the DOB to 01/01/1900  **/
        for(Account accObject:records){
           accObject.Name = accObject.Name + ' Mar';
           accObject.Date_of_Birth__c = Date.newInstance(1800,01,01);
           accObject.Person_email__c = 'xyz@gmail.com';
           accObject.Email__c ='xyz@gov.in';
           accObject.Active__c = 'Yes';
           lstOfAccountsToUpdate.add(accObject);
        }
        system.debug('@@@lstOfAccountsToUpdate:'+lstOfAccountsToUpdate);
        /*** Update the account records***/
        if(!lstOfAccountsToUpdate.isEmpty()){
            //Database.update(lstOfAccountsToUpdate,false);
            update lstOfAccountsToUpdate;
            
        }
        
    }
    public void finish(Database.BatchableContext bc){
    }
}
# http://stackoverflow.com/questions/35271160/how-do-i-fetch-all-cloudkit-records-created-by-the-current-user

let container: CKContainer = CKContainer.defaultContainer()
let completionHandler: (CKRecordID?, NSError?) -> Void = { (userRecordID: CKRecordID?, error: NSError?) in
if let userRecordID = userRecordID {
let predicate = NSPredicate(format: "creatorUserRecordID == %@", userRecordID)
let query = CKQuery(recordType: "Species", predicate: predicate)
query.sortDescriptors = [NSSortDescriptor(key: "latinName", ascending: true)]
container.publicCloudDatabase.performQuery(query, inZoneWithID: nil) { (records, error) -> Void in

}
}
}
//// Returns the user record ID associated with the current user.
container.fetchUserRecordIDWithCompletionHandler(completionHandler)


CKContainer.default().requestApplicationPermission(.userDiscoverability) { (status, error) in  
CKContainer.default().fetchUserRecordID { (record, error) in  
CKContainer.default().discoverUserIdentity(withUserRecordID: record!, completionHandler: { (userID, error) in  
print(userID?.hasiCloudAccount)  
print(userID?.lookupInfo?.phoneNumber)  
print(userID?.lookupInfo?.emailAddress)  
print((userID?.nameComponents?.givenName)! + " " + (userID?.nameComponents?.familyName)!)  
})  
}  
}  

//
//  UserItem.swift
//  geoMessenger
//
//  Created by chengen Zheng on 2017/10/31.
//  Copyright © 2017年 chengen Zheng. All rights reserved.
//

import Foundation
import Firebase

struct UserItem {
    
    let key: String
    let lastName: String
    let firstName: String
    let ref: DatabaseReference?
    var isApproved: Bool
    
    init(lastName: String, firstName: String, isApproved: Bool, key: String = "") {
        self.key = key
        self.lastName = lastName
        self.firstName = firstName
        self.isApproved = isApproved
        self.ref = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        lastName = snapshotValue["LastName"] as! String // must map to firebase names
        firstName = snapshotValue["FirstName"] as! String
        isApproved = snapshotValue["IsApproved"] as! Bool
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "lastName": lastName,
            "firstName": firstName,
            "isApproved": isApproved
        ]
    }
    
}


//
//  User.swift
//  InstaSimple
//
//  Created by Gaurav Shah on 1/1/21.
//

import Foundation

class User {
    var uid: String
    var email: String?
    var displayName: String?
    var postnum: Int
    
    init(uid: String, email: String?, displayName: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.postnum = 0
    }
    
    func addpost(){
        self.postnum += 1
    }
}

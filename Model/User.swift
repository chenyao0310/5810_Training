//
//  User.swift
//  5810_Training
//
//  Created by 振耀 on 2025/3/12.
//

import Foundation

struct User {
    
    var account: String
    var password: String
    var gender: String
    var education: String
    
    init(account: String, password: String, gender: String, education: String) {
        self.account = account
        self.password = password
        self.gender = gender
        self.education = education
    }
    
}

extension User {
    static let user1 = User(account: "admin", password: "password", gender: "male", education: "high school")
}

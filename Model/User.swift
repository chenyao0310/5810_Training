//
//  User.swift
//  5810_Training
//
//  Created by 振耀 on 2025/3/12.
//

import Foundation

struct User {
    
    let account: String
    let password: String
    
    init(account: String, password: String) {
        self.account = account
        self.password = password
    }
    
}

extension User {
    static let user1 = User(account: "admin", password: "password")
}

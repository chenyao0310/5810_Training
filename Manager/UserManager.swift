//
//  UserManager.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/17.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    var users: [User] = [User(account: "admin", password: "password", gender: "Male", education: "high school")]
    
}

extension UserManager {
    
    func register(account: String, password: String, gender: String, education: String) {
        users.append(User(account: account, password: password, gender: gender, education: education))
//        print(users)
    }
    
    func login(_ account: String, _ password: String) -> Bool {
        return users.contains(where: { $0.account == account && $0.password == password })
    }
}

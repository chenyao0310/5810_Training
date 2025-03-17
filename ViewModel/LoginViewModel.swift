//
//  LoginViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/17.
//

import Foundation
import UIKit

class LoginViewModel {
    
    var userManager: UserManager = .shared
    var account: String = ""
    var password: String = ""
    var loginStatus: ((Bool) -> Void)?
}

// MARK: - Sub

extension LoginViewModel{
    
    func login(){
        let success = userManager.login(account, password)
        loginStatus?(success)
    }
    
}


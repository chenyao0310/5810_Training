//
//  RegisterViewModel.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/17.
//

import Foundation

class RegisterViewModel {
    
    private let userManager: UserManager = .shared
    let educationOptions: [String] = ["Doctorate", "Master", "Bachelor"]
    var account: String = ""
    var password: String = ""
    var gender: String = "Male"
    var education: String = "Doctorate"
    var isAgree: Bool = false
    var error: String?
    var registerIsSuccess: ((Bool) -> Void)?
}

// MARK: - Sub

extension RegisterViewModel {
    
    func register(){
        error = allFieldsIsRight()?.rawValue
        if error == nil {
            userManager.register(account: account, password: password, gender: gender, education: education)
        }
        registerIsSuccess?(error == nil)
    }
}



// MARK: - Error

extension RegisterViewModel {
    
    enum RegisterError: String, Error{
        case emptyFields = "Please fill all fields"
        case passwordLengthError = "Password must be at least 8 characters long"
        case characterError = "Please only use letters, numbers"
        case educationError = "please select education"
        case agreeError = "Please agree to the terms and conditions"
    }
    
    private func allFieldsIsRight() -> RegisterError? {
        if accountAndPasswordIsEmpty(account, password) {
            return .emptyFields
        } else if passwordLengthlessThanEight(password) {
            return .passwordLengthError
        } else if accountLettersAndNumbers(account) || passwordLettersAndNumbers(password) {
            return .characterError
        } else if educationIsEmpty() {
            return .educationError
        } else if agreeIsNotSelected() {
            return .agreeError
        }
        return nil
    }
    
    private func accountAndPasswordIsEmpty(_ account: String, _ password: String) -> Bool {
        guard account != "" && password != "" else { return true }
        return false
    }
    
    private func passwordLengthlessThanEight(_ password: String) -> Bool {
        return password.count < 8
    }
    
    private func accountLettersAndNumbers(_ account: String) -> Bool {
        return account.rangeOfCharacter(from: .letters) == nil || account.rangeOfCharacter(from: .decimalDigits) == nil
    }
    
    private func passwordLettersAndNumbers(_ password: String) -> Bool {
        return password.rangeOfCharacter(from: .letters) == nil || password.rangeOfCharacter(from: .decimalDigits) == nil
    }
    
    private func educationIsEmpty() -> Bool {
        guard !education.isEmpty else { return true }
        return false
    }
    
    private func agreeIsNotSelected() -> Bool {
        return isAgree == false
    }
}

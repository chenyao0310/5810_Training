//
//  LogInViewController.swift
//  5810_Training
//
//  Created by 振耀 on 2025/3/12.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var successView: UIView!
    
    private var userData = User.user1

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI

extension LogInViewController {
    
    private func setupUI() {
        view.backgroundColor = .gray
        accountTextFieldConfigura()
        passwordTextFieldConfigura()
        errorLabelConfigura()
        loginButtonConfigura()
        successViewConfigura()
    }
    
    private func accountTextFieldConfigura() {
        accountTextField.textColor = .black
        accountTextField.text = ""
        accountTextField.placeholder = "請輸入帳號"
        accountTextField.textAlignment = .left
        accountTextField.font = .systemFont(ofSize: 16)
        accountTextField.backgroundColor = .white
    }
    
    private func passwordTextFieldConfigura() {
        passwordTextField.textColor = .black
        passwordTextField.text = ""
        passwordTextField.placeholder = "請輸入密碼"
        passwordTextField.textAlignment = .left
        passwordTextField.font = .systemFont(ofSize: 16)
        passwordTextField.backgroundColor = .white
    }
    
    private func errorLabelConfigura() {
        errorLabel.isHidden = true
        errorLabel.textColor = .red
        errorLabel.font = .systemFont(ofSize: 24)
        errorLabel.text = "error"
        errorLabel.numberOfLines = 0
    }
    
    private func loginButtonConfigura() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    private func successViewConfigura() {
        let loginSuccessView = LoginSuccessView(frame: successView.bounds)
        loginSuccessView.delegate = self
        successView.isHidden = true
        successView.backgroundColor = .white
        successView.addSubview(loginSuccessView)
    }
}


// MARK: - Action
extension LogInViewController {
    
    @objc func login() {
        if accountTextField.text == userData.account && passwordTextField.text == userData.password {
            // Login
            successView.isHidden = false
            print("success")
        } else {
            errorLabel.isHidden = false
        }
    }
    
    @objc func register() {
        print("push to register")
    }
    
}

// MARK: - LoginSuccessDelegate
extension LogInViewController: LoginSuccessDelegate {
    
    func loginSuccess() {
        successView.isHidden = true
    }
    
}

protocol LoginSuccessDelegate: AnyObject {
    func loginSuccess()
}

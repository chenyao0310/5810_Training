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
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var successView: UIView!
    
    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
}

// MARK: - Binding

extension LogInViewController {
    
    private func bindViewModel() {
        viewModel.loginStatus = { [weak self] success in
            if success {
                self?.successViewSetup()
                self?.successView.isHidden = false
                self?.error.isHidden = true
            } else {
                self?.error.isHidden = false
            }
        }
    }
}

// MARK: - UI

extension LogInViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        setupTextField()
        errorLabelConfigura()
        loginButtonConfigura()
        registerButtonConfigura()
    }
    
    private func successViewSetup() {
        let loginSuccessView = LoginSuccessView(frame: successView.bounds)
        loginSuccessView.delegate = self
        successView.backgroundColor = .white
        successView.addSubview(loginSuccessView)
    }
    
}

// MARK: - TextField

extension LogInViewController {
    
    enum TextFieldType {
        case account
        case password
    }
    
    private func setupTextField() {
        textFieldConfigure(accountTextField, type: .account)
        textFieldConfigure(passwordTextField, type: .password)
    }
    
    private func textFieldConfigure(_ textField: UITextField, type: TextFieldType) {
        textField.text = ""
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.textAlignment = .left
        textField.font = .systemFont(ofSize: 16)
        
        switch type {
        case .account:
            textField.placeholder = "請輸入帳號"
        case .password:
            textField.placeholder = "請輸入密碼"
            textField.isSecureTextEntry = true
            textField.textContentType = .password
        }
    }
}

// MARK: - Lable

extension LogInViewController {
    
    private func errorLabelConfigura() {
        error.isHidden = true
        error.textColor = .red
        error.font = .systemFont(ofSize: 24)
        error.text = "error"
        error.numberOfLines = 0
    }
}

// MARK: - Button

extension LogInViewController {
    
    private func loginButtonConfigura() {
        login.setTitle("Login", for: .normal)
        login.addTarget(self, action: #selector(loginDidTap), for: .touchUpInside)
    }
    
    private func registerButtonConfigura() {
        register.setTitle("Register", for: .normal)
        register.addTarget(self, action: #selector(registerDidTap), for: .touchUpInside)
    }
}


// MARK: - Action

extension LogInViewController {
    
    @objc func loginDidTap() {
        viewModel.account = accountTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        viewModel.login()
    }
    
    @objc func registerDidTap() {
        let registerViewController = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        print("push to register")
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}

// MARK: - LoginSuccessDelegate

protocol LoginSuccessDelegate: AnyObject {
    func loginSuccess()
}

extension LogInViewController: LoginSuccessDelegate {
    
    func loginSuccess() {
        successView.isHidden = true
    }
}



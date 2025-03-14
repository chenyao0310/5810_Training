//
//  RegisterViewController.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/12.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var male: UIButton!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var female: UIButton!
    @IBOutlet weak var femaleLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var educationTextField: NoCareTextField!
    @IBOutlet weak var agreeLabel: UILabel!
    @IBOutlet weak var agree: UIButton!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var successView: UIView!
    
    let options: [String] = ["Doctorate", "Master", "Bachelor"]
    let pickerView = UIPickerView()
    let toolBar = UIToolbar()
    var isAgree: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI

extension RegisterViewController {
    
    private func setupUI() {
        view.backgroundColor = .white
        setupLabel()
        setupTextField()
        setupButton()
        errorConfigure()
        toolBarConConfigure()
    }
}

// MARK: - View

extension RegisterViewController {
    
    private func successViewSetup() {
        let registerSuccessView = RegisterSuccessView(frame: successView.bounds)
        registerSuccessView.delegate = self
        registerSuccessView.accountText = self.accountTextField.text ?? ""
        registerSuccessView.passwordText = self.passwordTextField.text ?? ""
        registerSuccessView.sexText = self.male.isSelected ? "Male" : "Female"
        registerSuccessView.educationText = self.educationTextField.text ?? ""
        registerSuccessView.updateUI()
        successView.backgroundColor = .gray
        successView.addSubview(registerSuccessView)
    }
}

// MARK: - Label

extension RegisterViewController {
    
    private func setupLabel() {
        labelConfigure(accountLabel, title: "Account")
        labelConfigure(passwordLabel, title: "Password")
        labelConfigure(agreeLabel, title: "Agree rule")
        labelConfigure(sexLabel, title: "Sex")
        labelConfigure(educationLabel, title: "Education")
    }
    
    private func labelConfigure(_ label: UILabel, title: String) {
        label.text = title
    }
    
    private func errorConfigure() {
        error.isHidden = true
        error.textColor = .red
        error.text = "error"
    }
}

// MARK: - TextField
extension RegisterViewController {
    
    enum TextFieldType {
        case account
        case password
        case education
    }
    
    private func setupTextField() {
        textFieldConfigure(accountTextField, type: .account)
        textFieldConfigure(passwordTextField, type: .password)
        textFieldConfigure(educationTextField, type: .education)
    }
    
    private func textFieldConfigure(_ textField: UITextField, type: TextFieldType) {
        textField.text = ""
        textField.backgroundColor = .white
        textField.textColor = .black
        
        switch type {
        case .account:
            accountTextField.placeholder = "請輸入帳號"
        case .password:
            passwordTextField.placeholder = "請輸入密碼"
            passwordTextField.isSecureTextEntry = true
        case .education:
            educationTextField.textAlignment = .center
            educationTextField.rightView = UIImageView(
                image: UIImage(systemName: "chevron.down"))
            educationTextField.rightViewMode = .always
            educationTextField.borderStyle = .line
            pickerView.delegate = self
            pickerView.dataSource = self
            educationTextField.inputView = pickerView
        }
    }
}
    
// MARK: - Button
    
extension RegisterViewController {
    
    enum ButtonType {
        case gender
        case agree
        case register
    }
    
    private func setupButton() {
        buttonConfigure(male, type: .gender)
        buttonConfigure(female, type: .gender)
        buttonConfigure(agree, type: .agree)
        buttonConfigure(register, type: .register)
    }
    
    private func buttonConfigure(_ button: UIButton, type: ButtonType) {
        button.setTitle("", for: .normal)
        
        switch type {
        case .gender:
            updateSelectButton(isSelected: male, deSelected: female)
            genderButtonStyle(button)
        case .agree:
            button.setImage(UIImage(systemName: "circle"),for: .normal)
            button.addTarget(self, action: #selector(agreeButtonDidTap), for: .touchUpInside)
        case .register:
            button.setTitle("Register", for: .normal)
            button.addTarget(self, action: #selector(registerButtonDidTap), for: .touchUpInside)
        }
        
    }

    private func genderButtonStyle(_ button: UIButton) {
        let config = UIButton.Configuration.plain()
        
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .selected)
        button.addTarget(self, action: #selector(genderButtonTapped), for: .touchUpInside)
        button.configurationUpdateHandler = { button in
        var updateConfig = button.configuration
        updateConfig?.baseBackgroundColor = .white
        button.configuration = updateConfig
        }
        
        button.configuration = config
    }
    
}

// MARK: - ToolBar

extension RegisterViewController {
    
    private func toolBarConConfigure() {
        let doneButton = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(doneButtonDidTap))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexSpace, doneButton], animated: false)
        toolBar.sizeToFit()
        educationTextField.inputAccessoryView = toolBar
    }
}


// MARK: - Action

extension RegisterViewController {

    @objc private func registerButtonDidTap() {
        let registerError = registerValid()
        if registerError == nil {
            successViewSetup()
            successView.isHidden = false
            print("register success")
        } else {
            error.text = registerError?.rawValue
            error.isHidden = false
        }
            
    }

    @objc private func agreeButtonDidTap() {
        isAgree.toggle()
        agree.setImage(UIImage(systemName: isAgree ? "checkmark.circle" : "circle"), for: .normal)
    }

    @objc private func doneButtonDidTap() {
        educationTextField.resignFirstResponder()
    }

    @objc private func genderButtonTapped(_ sender: UIButton) {
        if sender == male {
            updateSelectButton(isSelected: male, deSelected: female)
        } else {
            updateSelectButton(isSelected: female, deSelected: male)
        }
    }

    private func updateSelectButton(isSelected: UIButton, deSelected: UIButton)
    {
        isSelected.isSelected = true
        deSelected.isSelected = false
    }
    
    
}
// MARK: - Error

extension RegisterViewController {
    
    enum RegisterError: String, Error{
        case emptyFields = "Please fill all fields"
        case passwordLengthError = "Password must be at least 8 characters long"
        case characterError = "Please only use letters, numbers"
        case educationError = "please select education"
        case agreeError = "Please agree to the terms and conditions"
    }
    
    private func registerValid() -> RegisterError? {
        guard let account = accountTextField.text, account != "" else { return .emptyFields }
        guard let password = passwordTextField.text, password != "" else { return .emptyFields }
        
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
        guard let account = accountTextField.text, account != "" else { return true }
        guard let password = passwordTextField.text, password != "" else { return true }
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
        guard let education = educationTextField.text, !education.isEmpty else { return true }
        return false
    }
    
    private func agreeIsNotSelected() -> Bool {
        return isAgree == false
    }
    
}

// MARK: - PickerDataSource

extension RegisterViewController: UIPickerViewDelegate {}

extension RegisterViewController: UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,inComponent component: Int) {
        educationTextField.text = options[row]
    }
}


// MARK: - RegisterSuccessDelegate

extension RegisterViewController: RegisterSuccessDelegate {
    
    func registerSuccess() {
        successView.isHidden = true
    }
}


protocol RegisterSuccessDelegate: AnyObject {
    
    func registerSuccess()
}

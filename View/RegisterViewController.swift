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
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
}

// MARK: - Binding

extension RegisterViewController {
    
    private func bindViewModel() {
        viewModel.registerIsSuccess = { [weak self] success in
            if success {
                self?.successViewSetup()
                self?.successView.isHidden = false
                self?.error.isHidden = true
                
            } else {
                self?.error.text = self?.viewModel.error
                self?.error.isHidden = false
            }
        }
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
        registerSuccessView.account.text! += viewModel.account
        registerSuccessView.password.text! += viewModel.password
        registerSuccessView.sex.text! += viewModel.gender
        registerSuccessView.education.text! += viewModel.education
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
            educationTextField.rightView = UIImageView(image: UIImage(systemName: "chevron.down"))
            educationTextField.rightViewMode = .always
            educationTextField.borderStyle = .line
            educationTextField.text = viewModel.educationOptions.first
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.selectRow(0, inComponent: 0, animated: false)
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
        
        toolbar.items = [flexSpace, doneButton]
        toolbar.sizeToFit()
        educationTextField.inputAccessoryView = toolbar
    }
}


// MARK: - Action

extension RegisterViewController {

    @objc private func registerButtonDidTap() {
        viewModel.account = accountTextField.text ?? ""
        viewModel.password = passwordTextField.text ?? ""
        viewModel.gender = male.isSelected ? "Male" : "Female"
        viewModel.education = educationTextField.text ?? ""
        viewModel.register()
    }

    @objc private func agreeButtonDidTap() {
        viewModel.isAgree.toggle()
        agree.setImage(UIImage(systemName: viewModel.isAgree ? "checkmark.circle" : "circle"), for: .normal)
    }

    @objc private func doneButtonDidTap() {
        if educationTextField.text?.isEmpty ?? true {
            educationTextField.text = viewModel.education
        }
        educationTextField.resignFirstResponder()
    }

    @objc private func genderButtonTapped(_ sender: UIButton) {
        if sender == male {
            updateSelectButton(isSelected: male, deSelected: female)
        } else {
            updateSelectButton(isSelected: female, deSelected: male)
        }
    }

    private func updateSelectButton(isSelected: UIButton, deSelected: UIButton) {
        isSelected.isSelected = true
        deSelected.isSelected = false
    }
    
    
}

// MARK: - PickerDataSource

extension RegisterViewController: UIPickerViewDelegate {}

extension RegisterViewController: UIPickerViewDataSource {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.educationOptions.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.educationOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int,inComponent component: Int) {
        educationTextField.text = viewModel.educationOptions[row]
    }
}


// MARK: - RegisterSuccessDelegate

extension RegisterViewController: RegisterSuccessDelegate {
    
    func registerSuccess() {
        self.navigationController?.popViewController(animated: true)
    }
}


protocol RegisterSuccessDelegate: AnyObject {
    func registerSuccess()
}

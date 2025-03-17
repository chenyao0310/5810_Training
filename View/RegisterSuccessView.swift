//
//  RegisterSuccessView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/13.
//

import UIKit

class RegisterSuccessView: UIView {

    @IBOutlet weak var account: UILabel!
    @IBOutlet weak var password: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var education: UILabel!
    @IBOutlet weak var ok: UIButton!
    
    weak var delegate: RegisterSuccessDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - View

extension RegisterSuccessView {
     
    private func setupView() {
        let view = loadFormNib()
        view.frame = self.bounds
        view.backgroundColor = .systemGray4
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        setupLabel()
        setupButton()
    }
    
    private func loadFormNib() -> UIView {
        let nib = UINib(nibName: "RegisterSuccessViewXib", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
    
// MARK: - Lable

extension RegisterSuccessView {
    
    enum LabelType {
        case account
        case password
        case gender
        case education
    }
    
    private func setupLabel() {
        labelConfigure(account, type: .account)
        labelConfigure(password, type: .password)
        labelConfigure(sex, type: .gender)
        labelConfigure(education, type: .education)
    }
    
    private func labelConfigure(_ label: UILabel, type: LabelType) {
        label.text = ""
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        switch type {
            
        case .account:
            label.text = "Account: "
        case .password:
            label.text = "Password: "
        case .gender:
            label.text = "Sex: "
        case .education:
            label.text = "Education: "
        }
    }
}

// MARK: - Button

extension RegisterSuccessView {
    
    private func setupButton() {
        ok.setTitle("OK", for: .normal)
        ok.addTarget(self, action: #selector(okButtonDidTap), for: .touchUpInside)
    }
}

// MARK: - Delegate

extension RegisterSuccessView {
    @objc func okButtonDidTap() {
        delegate?.registerSuccess()
    }
}

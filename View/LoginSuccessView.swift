//
//  LoginSuccessView.swift
//  8510_Training
//
//  Created by 振耀 on 2025/3/12.
//

import UIKit

class LoginSuccessView: UIView {

    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    weak var delegate: LoginSuccessDelegate?
    
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

//MARK: - UI

extension LoginSuccessView {
    
    private func setupView() {
        let view = loadFormNib()
        view.frame = self.bounds
        addSubview(view)
        okButtonconfig()
        successLabelConfig()
    }
    
     func successLabelConfig() {
        successLabel.text = "Login Success"
        successLabel.font = .systemFont(ofSize: 20, weight: .light)
        successLabel.numberOfLines = 0
    }
    
     func okButtonconfig() {
        okButton.setTitle("OK", for: .normal)
        okButton.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
    }
    
    private func loadFormNib() -> UIView {
        let nib = UINib(nibName: "LoginSuccessViewXib", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
}


extension LoginSuccessView {
    
    @objc func okButtonAction() {
        delegate?.loginSuccess()
    }
}

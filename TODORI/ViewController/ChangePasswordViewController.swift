//
//  ChangePasswordViewController.swift
//  TODORI
//
//  Created by Dasol on 2023/05/15.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    private let presentPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 비밀번호"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let presentPasswordTextField: UITextField = {
        let textField = UITextField()
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.borderStyle = .none
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(red: 0.817, green: 0.817, blue: 0.817, alpha: 1).cgColor
        
        textField.layer.cornerRadius = 8
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        return textField
    }()
    
    private let presentPasswordErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 비밀번호와 일치하지 않습니다."
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor(red: 1, green: 0.616, blue: 0.302, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private let newPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "새 비밀번호"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let newPasswordTextField: UITextField = {
        let textField = UITextField()
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.borderStyle = .none
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(red: 0.817, green: 0.817, blue: 0.817, alpha: 1).cgColor
        
        textField.layer.cornerRadius = 8
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        return textField
    }()
    
    private let newPasswordErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 생성 규칙에 맞지 않습니다."
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor(red: 1, green: 0.616, blue: 0.302, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private let checkNewPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "새 비밀번호 확인"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkNewPasswordTextField: UITextField = {
        let textField = UITextField()
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.borderStyle = .none
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(red: 0.817, green: 0.817, blue: 0.817, alpha: 1).cgColor
        
        textField.layer.cornerRadius = 8
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.snp.makeConstraints { make in
            make.height.equalTo(45)
        }
        return textField
    }()
    
    private let checkNewPasswordErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "새 비밀번호가 일치하지 않습니다."
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor(red: 1, green: 0.616, blue: 0.302, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private let finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("변경 완료", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.725, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupUI()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            self.view.endEditing(true)
    }
    
    private func setupUI() {
        // 네비게이션 바 설정
//        let separatorView = UIView(frame: CGRect(x: 0, y: navigationController?.navigationBar.frame.maxY ?? 0 - 1, width: view.frame.width, height: 1))
//        separatorView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
//        navigationController?.navigationBar.addSubview(separatorView)
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1)
        
        let font = UIFont.systemFont(ofSize: 16, weight: .bold)
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.black]
        let title = "비밀번호 변경"
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationItem.title = title
        
        let stackView = UIStackView(arrangedSubviews: [presentPasswordLabel, presentPasswordTextField, presentPasswordErrorLabel, newPasswordLabel, newPasswordTextField, newPasswordErrorLabel, checkNewPasswordLabel, checkNewPasswordTextField, checkNewPasswordErrorLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        view.addSubview(finishButton)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(47)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        finishButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(52)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        finishButton.addTarget(self, action: #selector(findButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func findButtonTapped() {
        if let password = presentPasswordTextField.text, let newPassword = newPasswordTextField.text {
            if isValidPassword(newPassword) {
                newPasswordErrorLabel.isHidden = true
                if newPasswordTextField.text == checkNewPasswordTextField.text {
                    checkNewPasswordErrorLabel.isHidden = true
                    changePassword(originPassword: password, newPassword: newPassword)
                } else {
                    checkNewPasswordErrorLabel.isHidden = false
                }
            } else {
                newPasswordErrorLabel.isHidden = false
            }
        } else {
            print("else")
        }
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z[0-9]$@$#!%*?&]{8,15}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return passwordPredicate.evaluate(with: password)
    }
}

extension ChangePasswordViewController {
    
    func changePassword(originPassword: String, newPassword: String) {
        UserService.shared.changePassword(originPassword: originPassword, newPassword: newPassword) {
            response in
            switch response {
            case .success(let data):
                if let json = data as? [String: Any],
                   let resultCode = json["resultCode"] as? Int {
                    if resultCode == 200 {
                        print("이백")
                        self.presentPasswordErrorLabel.isHidden = true
                    } else if resultCode == 500 {
                        print("오백")
                        self.presentPasswordErrorLabel.isHidden = false
                    }
                }
            case .failure:
                print("FUCKING fail")
            }
        }
    }
}

//
//  EnterProfileViewController.swift
//  TODORI
//
//  Created by Dasol on 2023/05/02.
//

import UIKit

class EnterProfileViewController: UIViewController {
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "3/3"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor(red: 0.621, green: 0.621, blue: 0.621, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "프로필을\n설정해 주세요"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailBoxLabel: UILabel = {
        let label = UILabel()
        
        if let email = UserDefaults.standard.string(forKey: "email") {
            label.text = "   " + email
        }
        label.textAlignment = .left
        label.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.layer.cornerRadius = 8

        label.clipsToBounds = true

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nickNameTextField: UITextField = {
        let textField = UITextField()
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .regular),
            .foregroundColor: UIColor(red: 0.837, green: 0.837, blue: 0.837, alpha: 1)
        ]
        let attributedPlaceholder = NSAttributedString(string: "2~6 글자로 입력해 주세요", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        
        let underlineView = UIView()
        underlineView.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        textField.addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.height.equalTo(1.5)
            make.top.equalTo(textField.snp.bottom).offset(7)
            make.leading.trailing.equalTo(textField)
        }
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let nickNameGenerationErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임 생성 규칙에 맞지 않습니다."
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor(red: 1, green: 0.616, blue: 0.302, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .regular),
            .foregroundColor: UIColor(red: 0.837, green: 0.837, blue: 0.837, alpha: 1)
        ]
        let attributedPlaceholder = NSAttributedString(string: "8자 이상 대문자, 소문자, 특수문자를 포함해 주세요.", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        
        let underlineView = UIView()
        underlineView.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        textField.addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.height.equalTo(1.5)
            make.top.equalTo(textField.snp.bottom).offset(7)
            make.leading.trailing.equalTo(textField)
        }
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordGenerationErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 생성 규칙에 맞지 않습니다."
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor(red: 1, green: 0.616, blue: 0.302, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private let checkPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkPasswordTextField: UITextField = {
        let textField = UITextField()
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .regular),
            .foregroundColor: UIColor(red: 0.837, green: 0.837, blue: 0.837, alpha: 1)
        ]
        let attributedPlaceholder = NSAttributedString(string: "8자 이상 대문자, 소문자, 특수문자를 포함해 주세요.", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder

        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        
        let underlineView = UIView()
        underlineView.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        textField.addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.height.equalTo(1.5)
            make.top.equalTo(textField.snp.bottom).offset(7)
            make.leading.trailing.equalTo(textField)
        }
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordInconsistencyErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호가 일치하지 않습니다."
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor(red: 1, green: 0.616, blue: 0.302, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("이전", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        button.layer.cornerRadius = 18
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.725, alpha: 1)
        button.layer.cornerRadius = 18
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var stackView = UIStackView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func setUI() {
        let stackView = UIStackView(arrangedSubviews: [nickNameLabel, nickNameTextField, nickNameGenerationErrorLabel, passwordLabel, passwordTextField, passwordGenerationErrorLabel, checkPasswordLabel, checkPasswordTextField, passwordInconsistencyErrorLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        if let index = stackView.arrangedSubviews.firstIndex(of: nickNameGenerationErrorLabel) {
            stackView.setCustomSpacing(18, after: stackView.arrangedSubviews[index - 1])
        }
        
        if let index = stackView.arrangedSubviews.firstIndex(of: passwordLabel) {
            stackView.setCustomSpacing(20, after: stackView.arrangedSubviews[index - 1])
        }

        if let index = stackView.arrangedSubviews.firstIndex(of: passwordLabel) {
            stackView.setCustomSpacing(20, after: stackView.arrangedSubviews[index - 2])
        }
        
        if let index = stackView.arrangedSubviews.firstIndex(of: passwordGenerationErrorLabel) {
            stackView.setCustomSpacing(18, after: stackView.arrangedSubviews[index - 1])
        }
        
        if let index = stackView.arrangedSubviews.firstIndex(of: checkPasswordLabel) {
            stackView.setCustomSpacing(20, after: stackView.arrangedSubviews[index - 1])
        }
        
        if let index = stackView.arrangedSubviews.firstIndex(of: checkPasswordLabel) {
            stackView.setCustomSpacing(20, after: stackView.arrangedSubviews[index - 2])
        }
        
        if let index = stackView.arrangedSubviews.firstIndex(of: checkPasswordLabel) {
            stackView.setCustomSpacing(20, after: stackView.arrangedSubviews[index - 2])
        }
        
        if let index = stackView.arrangedSubviews.firstIndex(of: passwordInconsistencyErrorLabel) {
            stackView.setCustomSpacing(18, after: stackView.arrangedSubviews[index - 1])
        }

        view.addSubview(numberLabel)
        view.addSubview(titleLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailBoxLabel)
//        view.addSubview(nickNameLabel)
        view.addSubview(stackView)
//        view.addSubview(nickNameTextField)
//        view.addSubview(nickNameGenerationErrorLabel)
//        view.addSubview(passwordLabel)
//        view.addSubview(passwordTextField)
//        view.addSubview(passwordGenerationErrorLabel)
//        view.addSubview(checkPasswordLabel)
//        view.addSubview(checkPasswordTextField)
//        view.addSubview(passwordInconsistencyErrorLabel)
        view.addSubview(backButton)
        view.addSubview(nextButton)
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.15)
            make.leading.equalToSuperview().offset(25)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(25)
        }

        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(25)
        }

        emailBoxLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(25)
            make.width.equalTo(340)
            make.height.equalTo(41)
        }
        
//        nickNameLabel.snp.makeConstraints { make in
//            make.top.equalTo(emailBoxLabel.snp.bottom).offset(18)
//            make.leading.equalToSuperview().offset(25)
//        }
        
//        nickNameTextField.snp.makeConstraints { make in
//            make.top.equalTo(nickNameLabel.snp.bottom).offset(10)
//            make.leading.equalToSuperview().offset(25)
//            make.trailing.equalToSuperview().offset(-25)
//        }
//
//        nickNameGenerationErrorLabel.snp.makeConstraints { make in
//            make.top.equalTo(nickNameTextField.snp.bottom).offset(10)
//            make.leading.equalTo(nickNameTextField.snp.leading)
//            make.trailing.equalTo(nickNameTextField.snp.trailing)
//        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(emailBoxLabel.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
//        passwordLabel.snp.makeConstraints { make in
//            make.top.equalTo(nickNameTextField.snp.bottom).offset(20)
//            make.leading.equalToSuperview().offset(25)
//        }
//
//        passwordTextField.snp.makeConstraints { make in
//            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
//            make.leading.equalToSuperview().offset(25)
//            make.trailing.equalToSuperview().offset(-25)
//        }
//
//        checkPasswordLabel.snp.makeConstraints { make in
//            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
//            make.leading.equalToSuperview().offset(25)
//        }
//
//        checkPasswordTextField.snp.makeConstraints { make in
//            make.top.equalTo(checkPasswordLabel.snp.bottom).offset(10)
//            make.leading.equalToSuperview().offset(25)
//            make.trailing.equalToSuperview().offset(-25)
//        }
//
//        passwordInconsistencyErrorLabel.snp.makeConstraints { make in
//            make.top.equalTo(checkPasswordTextField.snp.bottom).offset(10)
//            make.leading.equalTo(checkPasswordTextField.snp.leading)
//            make.trailing.equalTo(checkPasswordTextField.snp.trailing)
//        }
//
        backButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.leading.equalToSuperview().offset(21)
            make.width.equalTo(77)
            make.height.equalTo(38)
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.trailing.equalToSuperview().offset(-21)
            make.width.equalTo(77)
            make.height.equalTo(38)
        }
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true, completion: nil) // 이전 뷰 컨트롤러로 이동
    }
    
    @objc func nextButtonTapped() {
        print("TAPPED")
        
        if let nickname = nickNameTextField.text, let password = passwordTextField.text {
            if isValidNickName(nickname) {
                nickNameGenerationErrorLabel.isHidden = true
                if isValidPassword(password) {
                    passwordGenerationErrorLabel.isHidden = true
                    if passwordTextField.text == checkPasswordTextField.text {
                        passwordInconsistencyErrorLabel.isHidden = true
                        print("다음 OK")
                        if let email = emailLabel.text {
                            register(nickname: nickname, email: email, password: password)                            
                        }
                    } else {
                        passwordInconsistencyErrorLabel.isHidden = false
                    }
                } else {
                    passwordGenerationErrorLabel.isHidden = false
                }
            } else {
                nickNameGenerationErrorLabel.isHidden = false
            }
            
        }
        
//        if let password = passwordTextField.text {
//            if isValidPassword(password) {
//                passwordGenerationErrorLabel.isHidden = true
//            } else {
//                passwordGenerationErrorLabel.isHidden = false
//            }
//        }
    }
    
    func isValidNickName(_ nickname: String) -> Bool {
        if let nickname = nickNameTextField.text, (2...6).contains(nickname.count) {
            return true
        } else {
            return false
        }
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z[0-9]$@$#!%*?&]{8,15}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return passwordPredicate.evaluate(with: password)
    }
}

extension EnterProfileViewController {
    
    func register(nickname: String, email: String, password: String) {
        UserService.shared.register(nickname:nickname, email: email, password: password) {
            response in
            switch response {
            case .success(let data):
                if let json = data as? [String: Any],
                   let resultCode = json["resultCode"] as? Int {

                    if resultCode == 200 {
                        print("이백")
                        let viewControllerToPresent = FinishSignUpViewController() // 이동할 뷰 컨트롤러 인스턴스 생성
                        viewControllerToPresent.modalPresentationStyle = .fullScreen // 화면 전체를 차지하도록 설정
                        viewControllerToPresent.modalTransitionStyle = .coverVertical // coverHorizontal 스타일 적용
                        self.present(viewControllerToPresent, animated: true, completion: nil) // 뷰 컨트롤러 이동
                    } else if resultCode == 500 {
                        print("오백")
                    }
                }
            case .requestErr(let err):
                print(err)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            case .decodeErr:
                print("decodeErr")
            }
        }
    }
}

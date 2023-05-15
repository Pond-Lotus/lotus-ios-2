//
//  LogInViewController.swift
//  TODORI
//
//  Created by Dasol on 2023/05/01.
//

import UIKit
// import SnapKit 없어도 적용이 되는 이유?

class LogInViewController: UIViewController {

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo-image")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let logoTextView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo-text")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .medium),
            .foregroundColor: UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1)
        ]
        let attributedPlaceholder = NSAttributedString(string: "이메일 입력", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        textField.layer.cornerRadius = 18
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .medium),
            .foregroundColor: UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1)
        ]
        let attributedPlaceholder = NSAttributedString(string: "비밀번호 입력", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
        textField.leftView = paddingView
        textField.leftViewMode = .always
                    
        let passwordVisionButton = UIButton(type: .custom)
        passwordVisionButton.setImage(UIImage(named: "password-invision")?.resize(to: CGSize(width: 24, height: 24)), for: .normal)
        passwordVisionButton.addTarget(self, action: #selector(passwordVisionButtonTapped), for: .touchUpInside)
        passwordVisionButton.setImage(UIImage(named: "password-vision")?.resize(to: CGSize(width: 24, height: 24)), for: .selected)
        passwordVisionButton.frame = CGRect(x: 0, y: (30 - 24) / 2, width: 24, height: 24) // 버튼 프레임 설정
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 39, height: 30))
        textField.rightView = rightPaddingView
        textField.rightViewMode = .always
        rightPaddingView.addSubview(passwordVisionButton) // 버튼을 rightPaddingView에 추가
                
        textField.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        textField.layer.cornerRadius = 18
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let autoLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 자동 로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        
        // 1
        let image = UIImage(named: "tick-circle")?.resize(to: CGSize(width: 17, height: 17))
        button.setImage(image, for: .normal)
        // 2
        button.setImage(UIImage(named: "tick-circle2")?.resize(to: CGSize(width: 17, height: 17)), for: .selected)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.725, alpha: 1)
        button.layer.cornerRadius = 18
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let findPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원 가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
        
        emailTextField.delegate = self
        
        autoLoginButton.addTarget(self, action: #selector(autoLoginTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        findPasswordButton.addTarget(self, action: #selector(findPasswordTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        
    }
    
    private func setupUI() {
        view.addSubview(logoImageView)
        view.addSubview(logoTextView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(autoLoginButton)
        view.addSubview(loginButton)
        view.addSubview(findPasswordButton)
        view.addSubview(signupButton)
        
        logoImageView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).multipliedBy(2)
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.15)
            make.centerX.equalToSuperview()
            make.width.equalTo(117)
            make.height.equalTo(117)
        }
        
        logoTextView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(103)
            make.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoTextView.snp.bottom).offset(67)
            make.centerX.equalToSuperview()
            make.width.equalTo(308)
            make.height.equalTo(54)
        }   
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(308)
            make.height.equalTo(54)
        }
        
        autoLoginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.equalTo(loginButton.snp.leading).offset(0)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(65)
            make.centerX.equalToSuperview()
            make.width.equalTo(308)
            make.height.equalTo(49)
        }
        
        findPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(13)
            make.leading.equalTo(loginButton.snp.leading).offset(0)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(13)
            make.trailing.equalTo(loginButton.snp.trailing).offset(0)
        }
    }
    
    @objc private func loginTapped() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            if autoLoginButton.isSelected {
                print("isSelected")
                UserDefaults.standard.set(true, forKey: "autoLogin")
                saveLoginInfo(email: email, password: password)
                login(email: email, password: password)
            } else {
                print("isNotSelected")
                UserDefaults.standard.set(false, forKey: "autoLogin")
                login(email: email, password: password)
            }
        }
    }
    
    @objc private func signupTapped() {
        let viewControllerToPresent = EnterEmailViewController() // 이동할 뷰 컨트롤러 인스턴스 생성
        viewControllerToPresent.modalPresentationStyle = .fullScreen // 화면 전체를 차지하도록 설정
//        viewControllerToPresent.modalTransitionStyle = .coverVertical // coverHorizontal 스타일 적용
        present(viewControllerToPresent, animated: true, completion: nil) // 뷰 컨트롤러 이동
    }
    
    func saveLoginInfo(email: String, password: String) {
        UserDefaults.standard.setValue(email, forKey: "email")
        UserDefaults.standard.setValue(password, forKey: "password")
    }
    
    @objc func autoLoginTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func findPasswordTapped(_ sender: UIButton) {
        let navController = UINavigationController(rootViewController: FindPasswordViewController())
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func closeCircleButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        emailTextField.text = ""
        emailTextField.rightView?.isHidden = true
    }
    
    @objc func passwordVisionButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }
}

// 따로 빼야할 듯
extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // 입력된 텍스트가 비어있지 않으면 버튼 이미지 보여주기
        if !newText.isEmpty {
            let closeButton = UIButton(type: .custom)
            closeButton.setImage(UIImage(named: "close-circle")?.resize(to: CGSize(width: 24, height: 24)), for: .normal)
            closeButton.addTarget(self, action: #selector(closeCircleButtonTapped), for: .touchUpInside)
            closeButton.frame = CGRect(x: 0, y: (30 - 24) / 2, width: 24, height: 24) // 버튼 프레임 설정
            
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 39, height: 30))
            textField.rightView = rightPaddingView
            textField.rightViewMode = .always
            rightPaddingView.addSubview(closeButton) // 버튼을 rightPaddingView에 추가
        } else {
            textField.rightView = nil
            textField.rightViewMode = .never
        }
        
        return true
    }

}

extension LogInViewController {
    
    func login(email: String, password: String) {
        UserService.shared.login(email: email, password: password) {
            response in
            switch response {
            case .success(let data):
                if let json = data as? [String: Any],
                   let resultCode = json["resultCode"] as? Int {
                    
                    if resultCode == 200 {
                        print("이백")
                        print(json["token"])
                        if let token = json["token"] {
                            UserDefaults.standard.set(token, forKey: "token")
                        } else {
                            print("토큰 저장 안 됨")
                        }
                        
                        let viewControllerToPresent = FinishSignUpViewController() // 이동할 뷰 컨트롤러 인스턴스 생성
                        viewControllerToPresent.modalPresentationStyle = .fullScreen // 화면 전체를 차지하도록 설정
                        viewControllerToPresent.modalTransitionStyle = .coverVertical // coverHorizontal 스타일 적용
                        self.present(viewControllerToPresent, animated: true, completion: nil) // 뷰 컨트롤러 이동
                    } else if resultCode == 500 {
                        print("오백")
                        
                        let popupView = CustomPopupView(title: "로그인 실패", message: "이메일 혹은 비밀번호를 다시 확인해 주세요.", buttonText: "확인")
                        self.view.addSubview(popupView)
                        popupView.snp.makeConstraints { make in
                            make.center.equalToSuperview()
                            //                            make.width.equalToSuperview().multipliedBy(0.8)
                            make.width.equalTo(290)
                            make.height.equalTo(104)
                        }
                    }
                    
                }
            case .fail:
                print("FUCKING fail")
            }
        }
    }
}

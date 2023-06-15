//
//  LogInViewController.swift
//  TODORI
//
//  Created by Dasol on 2023/05/01.
//

import UIKit

class LogInViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo-image")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let logoTextView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo-text")
        imageView.contentMode = .scaleAspectFit
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
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none // 기본값은 .sentences로 문장의 첫 글자를 자동으로 대문자로 변환
        textField.autocorrectionType = .no // 기본값은 .default로 기본 자동 교정 동작을 사용
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
        passwordVisionButton.addTarget(nil, action: #selector(passwordVisionButtonTapped), for: .touchUpInside)
        passwordVisionButton.setImage(UIImage(named: "password-vision")?.resize(to: CGSize(width: 24, height: 24)), for: .selected)
        passwordVisionButton.frame = CGRect(x: 0, y: (30 - 24) / 2, width: 24, height: 24)
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 39, height: 30))
        textField.rightView = rightPaddingView
        textField.rightViewMode = .always
        rightPaddingView.addSubview(passwordVisionButton)
        
        textField.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.949, alpha: 1)
        textField.layer.cornerRadius = 18
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let autoLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 자동 로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.setImage(UIImage(named: "tick-circle")?.resize(to: CGSize(width: 17, height: 17)), for: .normal)
        button.setImage(UIImage(named: "tick-circle2")?.resize(to: CGSize(width: 17, height: 17)), for: .selected)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.applyColorAnimation()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = UIColor.mainColor
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let findPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 찾기", for: .normal)
        button.setTitleColor(UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return button
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        navigationController?.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        setupButton()
        setupTapGesture()
        setupUI()
        
        registerKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupButton() {
        autoLoginButton.addTarget(self, action: #selector(autoLoginTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        findPasswordButton.addTarget(self, action: #selector(findPasswordTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                let screenHeight = UIScreen.main.bounds.height - window.safeAreaInsets.top - window.safeAreaInsets.bottom
                make.height.equalTo(screenHeight)
            }
        }
        contentView.addSubview(logoImageView)
        contentView.addSubview(logoTextView)
        contentView.addSubview(emailTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(autoLoginButton)
        contentView.addSubview(loginButton)
        contentView.addSubview(findPasswordButton)
        contentView.addSubview(signupButton)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.17)
            make.centerX.equalToSuperview()
            make.width.equalTo(67)
            make.height.equalTo(90)
        }
        
        logoTextView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(103)
            make.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoTextView.snp.bottom).offset(67)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(UIScreen.main.bounds.width * 0.1)
            make.height.equalTo(54)
        }   
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(UIScreen.main.bounds.width * 0.1)
            make.height.equalTo(54)
        }
        
        autoLoginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.leading.equalTo(loginButton.snp.leading).offset(0)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(65)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(UIScreen.main.bounds.width * 0.1)
            make.height.equalTo(49)
        }
        
        findPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.leading.equalTo(loginButton.snp.leading).offset(0)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.trailing.equalTo(loginButton.snp.trailing).offset(0)
        }
    }
    
    @objc private func scrollViewTapped() {
        scrollView.endEditing(true)
    }
    
    @objc private func loginButtonTapped() {
        if emailTextField.text != "", passwordTextField.text != "" {
            if let email = emailTextField.text, let password = passwordTextField.text {
                loginButton.isEnabled = false
                loginButton.alpha = 0.7
                login(email: email, password: password)
            }
        }
    }
    
    @objc private func signupTapped() {
        navigationController?.pushViewController(EnterEmailViewController(), animated: true)
    }
    
    @objc func autoLoginTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func findPasswordTapped(_ sender: UIButton) {
        navigationController?.pushViewController(FindPasswordViewController(), animated: true)
    }
    
    @objc func closeCircleButtonTapped(_ sender: UIButton) {
        emailTextField.text = ""
        emailTextField.rightViewMode = .never
    }
    
    @objc private func passwordVisionButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTextField.isSecureTextEntry = !sender.isSelected
    }
    
    // MARK: - Keyboard Handling
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}

extension LogInViewController {
    func login(email: String, password: String) {
        UserService.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let response):
                self.loginButton.isEnabled = true
                self.loginButton.alpha = 1
                if response.resultCode == 200 {
                    print("이백")
                    guard let token = response.token,
                          let email = response.email,
                          let nickname = response.nickname
                    else {
                        print("가드 오류")
                        return
                    }
                    
                    if let base64Image = response.image {
                        let imageData = UserSession.shared.base64StringToImage(base64String: base64Image)?.pngData()
                        UserDefaults.standard.set(imageData, forKey: "image")
                    } else {
                        UserDefaults.standard.set(nil, forKey: "image")
                    }
                    
                    TokenManager.shared.saveToken(token)
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(nickname, forKey: "nickname")
                    
                    if self.autoLoginButton.isSelected {
                        UserDefaults.standard.set(true, forKey: "autoLogin")
                        print("자동로그인 O : \(UserDefaults.standard.bool(forKey: "autoLogin"))")
                    } else {
                        UserDefaults.standard.set(false, forKey: "autoLogin")
                        print("자동로그인 X : \(UserDefaults.standard.bool(forKey: "autoLogin"))")
                    }
                    
                    let nextVC = UINavigationController(rootViewController: ToDoMainViewController())
                    nextVC.modalPresentationStyle = .fullScreen
                    self.present(nextVC, animated: false)
                    
                } else if response.resultCode == 500 {
                    print("오백")
                    let dimmingView = UIView(frame: UIScreen.main.bounds)
                    dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                    dimmingView.alpha = 0
                    self.view.addSubview(dimmingView)
                    let popupView = CustomPopupView(title: "로그인 실패", message: "이메일 혹은 비밀번호를\n다시 확인해 주세요.", buttonText: "확인", buttonColor: UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1), dimmingView: dimmingView)
                    popupView.alpha = 0
                    self.view.addSubview(popupView)
                    popupView.snp.makeConstraints { make in
                        make.center.equalToSuperview()
                        make.width.equalTo(264)
                        make.height.equalTo(167)
                    }
                    UIView.animate(withDuration: 0.3) {
                        popupView.alpha = 1
                        dimmingView.alpha = 1
                    }
                }
            case .failure(let err):
                print("failure: \(err)")
                self.loginButton.isEnabled = true
                self.loginButton.alpha = 1
            }
        }
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == emailTextField {
            if !newText.isEmpty {
                let closeButton = UIButton(type: .custom)
                closeButton.setImage(UIImage(named: "close-circle")?.resize(to: CGSize(width: 24, height: 24)), for: .normal)
                closeButton.addTarget(self, action: #selector(closeCircleButtonTapped), for: .touchUpInside)
                closeButton.frame = CGRect(x: 0, y: (30 - 24) / 2, width: 24, height: 24)
                
                let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 39, height: 30))
                textField.rightView = rightPaddingView
                textField.rightViewMode = .always
                rightPaddingView.addSubview(closeButton)
            } else {
                textField.rightView = nil
                textField.rightViewMode = .never
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
}

extension LogInViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let navigationBar = navigationController?.navigationBar

        let maxOffsetY = UIScreen.main.bounds.height * 0.15
        let alpha = 1 - min(1, max(0, offsetY / maxOffsetY))
        navigationBar?.alpha = alpha
    }
}

extension LogInViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let isRootViewController = (viewController == navigationController.viewControllers.first)
        
        // Enable or disable the interactivePopGestureRecognizer based on the isRootViewController flag
        navigationController.interactivePopGestureRecognizer?.isEnabled = !isRootViewController
    }
}

extension LogInViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

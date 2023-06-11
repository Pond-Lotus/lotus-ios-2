//
//  EditProfileViewController.swift
//  TODORI
//
//  Created by Dasol on 2023/05/15.
//

import UIKit
import PhotosUI

class EditProfileViewController: UIViewController {
    var tmpImage: UIImage?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let editProfileImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit-profile-image")?.resize(to: CGSize(width: 26, height: 26)), for: .normal)
        return button
    }()
    
    private let nickNameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let nickNameTextField: UITextField = {
        let textField = UITextField()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .light),
            .foregroundColor:  UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
        ]
        let attributedPlaceholder: NSAttributedString?
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            attributedPlaceholder = NSAttributedString(string: nickname, attributes: attributes)
            textField.attributedPlaceholder = attributedPlaceholder
        }
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.borderStyle = .none
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor(red: 0.817, green: 0.817, blue: 0.817, alpha: 1).cgColor
        
        textField.layer.cornerRadius = 8
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let emailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        if let email = UserDefaults.standard.string(forKey: "email")  {
            label.text = "   " + email
        } else {
            label.text = "   " + "(NONE)"
        }
        
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = UIColor(red: 0.617, green: 0.617, blue: 0.617, alpha: 1)
        label.backgroundColor = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()
    
    private let changePasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 변경", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1).cgColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let deleteAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("계정 탈퇴하기", for: .normal)
        button.setTitleColor( UIColor(red: 0.554, green: 0.554, blue: 0.554, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.913, green: 0.913, blue: 0.913, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        editProfileImageButton.addTarget(self, action: #selector(editProfileImageButtonTapped), for: .touchUpInside)
        changePasswordButton.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        deleteAccountButton.addTarget(self, action: #selector(deleteAccountButtonTapped), for: .touchUpInside)
        
        setupUI()
        
        navigationController?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let email = UserDefaults.standard.string(forKey: "email")
        else {
            print("가드 오류")
            return
        }

        DispatchQueue.main.async {
            if let imageData = UserDefaults.standard.data(forKey: "image") {
                self.profileImageView.image = UIImage(data: imageData)
            } else {
                self.profileImageView.image = UIImage(named: "default-profile")
            }
        }
                
        emailLabel.text = "   " + email
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            self.view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let cornerRadius = min(self.profileImageView.bounds.width, self.profileImageView.bounds.height) / 2
        self.profileImageView.layer.cornerRadius = cornerRadius
    }
    
    private func setupUI() {
        NavigationBarManager.shared.setupNavigationBar(for: self, backButtonAction:  #selector(backButtonTapped), title: "프로필 수정", showSeparator: true)

        let completeButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonTapped))
//        if 조건 {
//            let attributes: [NSAttributedString.Key: Any] = [
//                .foregroundColor: UIColor.red, // 원하는 폰트 컬러로 설정
//                // 다른 원하는 속성들도 추가 가능
//            ]
//            button.setTitleTextAttributes(attributes, for: .normal)
//        }
        let completeButtonAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .medium) ,
        ]
        completeButton.setTitleTextAttributes(completeButtonAttributes, for: .normal)
        navigationItem.rightBarButtonItem = completeButton
        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 0.621, green: 0.621, blue: 0.621, alpha: 1)
        
        view.addSubview(profileImageView)
        view.addSubview(editProfileImageButton)
        view.addSubview(nickNameTitleLabel)
        view.addSubview(nickNameTextField)
        view.addSubview(emailTitleLabel)
        view.addSubview(emailLabel)
        view.addSubview(changePasswordButton)
        view.addSubview(deleteAccountButton)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(26)
            make.centerX.equalToSuperview()
            make.width.equalTo(89)
            make.height.equalTo(89)
        }
        
        editProfileImageButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(92.83)
            make.leading.equalTo(profileImageView.snp.leading).offset(62)
        }
      
        nickNameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(20)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameTitleLabel.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(45)
        }
        
        emailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(14)
            make.leading.equalToSuperview().offset(20)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTitleLabel.snp.bottom).offset(7)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(45)
        }
        
        changePasswordButton.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(45)
        }
        
        deleteAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-35)
            make.centerX.equalToSuperview()
            make.width.equalTo(93)
            make.height.equalTo(30)
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func completeButtonTapped() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = false
        guard let enteredNickname = nickNameTextField.text,
              let nickname = UserDefaults.standard.string(forKey: "nickname")
        else {
            navigationItem.rightBarButtonItem?.isEnabled = true
            print("가드 오류")
            return
        }
        
        if let imageData = UserSession.shared.image {
            if let image = UIImage(data: imageData) {
                if enteredNickname == "" {
                    self.editProfile(image: image, nickname: nickname, imdel: false)
                } else {
                    self.editProfile(image: image, nickname: enteredNickname, imdel: false)
                }
            }
        } else {
            if let image = UIImage(named: "default-profile") {
                if enteredNickname == "" {
                    self.editProfile(image: image, nickname: nickname, imdel: false)
                } else {
                    self.editProfile(image: image, nickname: enteredNickname, imdel: false)
                }
            }
        }
//        if let nickname = nickNameTextField.text {
//            if let imageData = UserSession.shared.image {
//                UserDefaults.standard.set(imageData, forKey: "image")
//                let image = UIImage(data: imageData)
//                if nickname == "" {
//                    if let nickname = UserDefaults.standard.string(forKey: "nickname") {
//                        navigationItem.rightBarButtonItem?.isEnabled = false
//                        self.editProfile(image: image, nickname: nickname, imdel: false)
//                    }
//                } else {
//                    navigationItem.rightBarButtonItem?.isEnabled = false
//                    self.editProfile(image: image, nickname: nickname, imdel: false)
//                }
//            } else {
//                if let image = UserDefaults.standard.string(forKey: "image") {
//                    let image = UserSession.shared.base64StringToImage(base64String: image)
//                    if nickname == "" {
//                        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
//                            navigationItem.rightBarButtonItem?.isEnabled = false
//                            self.editProfile(image: image, nickname: nickname, imdel: false)
//                        }
//                    } else {
//                        navigationItem.rightBarButtonItem?.isEnabled = false
//                        self.editProfile(image: image, nickname: nickname, imdel: false)
//                    }
//                }
//            }
//        } else {
//            print("완료 버튼 탭 에러")
//        }
    }

    @objc func editProfileImageButtonTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let albumAction = UIAlertAction(title: "앨범에서 선택", style: .default) { [weak self] _ in
            var configurcation = PHPickerConfiguration()
            configurcation.selectionLimit = 1
            
            let picker = PHPickerViewController(configuration: configurcation)
            picker.delegate = self
            
            self?.present(picker, animated: true, completion: nil)
        }
        
        let defaultImageAction = UIAlertAction(title: "기본 이미지로 설정", style: .default) { _ in
            self.profileImageView.image = UIImage(named: "default-profile")
            UserSession.shared.image = nil
        }
        
        let cancelAction = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        
        alertController.addAction(albumAction)
        alertController.addAction(defaultImageAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func changePasswordButtonTapped() {
        let nextVC = ChangePasswordViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func deleteAccountButtonTapped() {
        navigationController?.pushViewController(DeleteAccountViewController(), animated: true)
    }
}

extension EditProfileViewController {
    func editProfile(image: UIImage, nickname: String, imdel: Bool) {
        UserService.shared.editProfile(image: image, nickname: nickname, imdel: imdel) { result in
            switch result {
            case .success(let response):
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                if response.resultCode == 200 {
                    print("이백")
                    UserDefaults.standard.set(response.data["nickname"] , forKey: "nickname")
                    
                    if let base64Image = response.data["image"] {
                        let imageData = UserSession.shared.base64StringToImage(base64String: base64Image)?.pngData()
                        UserDefaults.standard.set(imageData, forKey: "image")
                        
                        let dimmingView = UIView(frame: UIScreen.main.bounds)
                        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                        dimmingView.alpha = 0
                        self.view.addSubview(dimmingView)
                        let popupView = CustomPopupView(title: "프로필 수정", message: "프로필 수정이 완료되었습니다.", buttonText: "확인", buttonColor: UIColor(red: 1, green: 0.855, blue: 0.725, alpha: 1), dimmingView: dimmingView)
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
                    } else {
                        print("response.data[\"image\"] == nil")
                        let imageData = UIImage(named: "default-profile")?.pngData()
                        UserDefaults.standard.set(imageData, forKey: "image")
                    }
                } else if response.resultCode == 500 {
                    print("오백")
                }
            case .failure(let err):
                print("FUCKING failure: \(err)")
            }
        }
    }
}

extension EditProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true) // 1
        
        guard let itemProvider = results.first?.itemProvider else {
            // 선택된 항목이 없을 경우 처리
            return
        }
        
//        if let image = UIImage(named: "exampleImage"),
//           let imageData = image.pngData() {
//            // 데이터를 UserDefaults에 저장
//            UserDefaults.standard.set(imageData, forKey: "imageData")
//        }
//
//        // 이미지 데이터를 가져옴
//        if let imageData = UserDefaults.standard.data(forKey: "imageData"),
//           let image = UIImage(data: imageData) {
//            // 가져온 이미지 사용
//            imageView.image = image
//        }
        
        if itemProvider.canLoadObject(ofClass: UIImage.self) { // 3
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in // 4
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        if let imageData = image.pngData() {
                            self.profileImageView.image = UIImage(data: imageData)
                            UserSession.shared.image = imageData
                        }
                    }
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
}

extension EditProfileViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController == self {
//            print("현재 뷰 컨트롤러가 보이는 경우")
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
        } else {
//            print("다른 뷰 컨트롤러가 보이는 경우")
            navigationController.interactivePopGestureRecognizer?.isEnabled = false
        }
    }
}

extension EditProfileViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

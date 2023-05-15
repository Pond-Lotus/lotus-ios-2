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
    
    private var profileImageView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "edit-profile")?.circleMasked)
        let imageView = UIImageView(image: UIImage(named: "default-profile")?.resize(to: CGSize(width: 89, height: 89)))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageView.frame.width / 2.0
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true

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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nickNameTextField: UITextField = {
        let textField = UITextField()
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .light),
            .foregroundColor:  UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)
        ]
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            let attributedPlaceholder = NSAttributedString(string: nickname, attributes: attributes)
            textField.attributedPlaceholder = attributedPlaceholder
        } else {
            let attributedPlaceholder = NSAttributedString(string: "(UKNOWN)", attributes: attributes)
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
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        if let email = UserDefaults.standard.string(forKey: "email") {
            label.text = "   " + email
        }
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = UIColor(red: 0.617, green: 0.617, blue: 0.617, alpha: 1)
        label.backgroundColor = UIColor(red: 0.946, green: 0.946, blue: 0.946, alpha: 1)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true

        label.translatesAutoresizingMaskIntoConstraints = false
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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        editProfileImageButton.addTarget(self, action: #selector(editProfileImageButtonTapped), for: .touchUpInside)
        changePasswordButton.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        
        setupUI()
    }
    
    private func setupUI() {
        // 네비게이션 바 설정
        let separatorView = UIView(frame: CGRect(x: 0, y: navigationController?.navigationBar.frame.maxY ?? 0 - 1, width: view.frame.width, height: 1))
        separatorView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        navigationController?.navigationBar.addSubview(separatorView)
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
//        navigationController?.navigationBar.tintColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1)
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1)
        
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
        
        let font = UIFont.systemFont(ofSize: 16, weight: .bold)
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationItem.title = "프로필 수정"
        
        view.addSubview(profileImageView)
        view.addSubview(editProfileImageButton)
        view.addSubview(nickNameTitleLabel)
        view.addSubview(nickNameTextField)
        view.addSubview(emailTitleLabel)
        view.addSubview(emailLabel)
        view.addSubview(changePasswordButton)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(26)
            make.centerX.equalToSuperview()
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
    }
    
    @objc func backButtonTapped() {
        //        navigationController?.popViewController(animated: true)
        let viewControllerToPresent = MyPageViewController() // 이동할 뷰 컨트롤러 인스턴스 생성
        viewControllerToPresent.modalPresentationStyle = .fullScreen // 화면 전체를 차지하도록 설정
        present(viewControllerToPresent, animated: true, completion: nil) // 뷰 컨트롤러 이동
    }
    
    @objc func completeButtonTapped() {

    }

    @objc func editProfileImageButtonTapped() {
        //        let alertController = UIAlertController(title: nil, message: "이미지를 선택하세요", preferredStyle: .actionSheet)
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let albumAction = UIAlertAction(title: "앨범에서 선택", style: .default) { [weak self] _ in
            var configurcation = PHPickerConfiguration()
            configurcation.selectionLimit = 1
            
            let picker = PHPickerViewController(configuration: configurcation)
            picker.delegate = self
            
            self?.present(picker, animated: true, completion: nil)
        }
        
        let defaultImageAction = UIAlertAction(title: "기본 이미지로 설정", style: .default) { [weak self] _ in
            self?.profileImageView.image = UIImage(named: "default-profile")?.resize(to: CGSize(width: 89, height: 89))
        }
        
        let cancelAction = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        
        alertController.addAction(albumAction)
        alertController.addAction(defaultImageAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func changePasswordButtonTapped() {
        let navController = UINavigationController(rootViewController: ChangePasswordViewController())
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
}

extension EditProfileViewController {
    //    func findPassword(email: String) {
    //        UserService.shared.findPassword(email: email) {
    //            response in
    //            switch response {
    //            case .success(let data):
    //                if let json = data as? [String: Any],
    //                   let resultCode = json["resultCode"] as? Int {
    //                    if resultCode == 200 {
    //                        print("이백")
    //                        self.errorLabel.isHidden = true
    ////                        let viewControllerToPresent = EnterCodeViewController() // 이동할 뷰 컨트롤러 인스턴스 생성
    ////                        viewControllerToPresent.modalPresentationStyle = .fullScreen // 화면 전체를 차지하도록 설정
    ////                        viewControllerToPresent.modalTransitionStyle = .coverVertical // coverHorizontal 스타일 적용
    ////                        self.present(viewControllerToPresent, animated: true, completion: nil) // 뷰 컨트롤러 이동
    //                    } else if resultCode == 500 {
    //                        print("오백")
    //                        self.errorLabel.isHidden = false
    //                    }
    //
    //                }
    //            case .requestErr(let err):
    //                print(err)
    //            case .pathErr:
    //                print("pathErr")
    //            case .serverErr:
    //                print("serverErr")
    //            case .networkFail:
    //                print("networkFail")
    //            case .decodeErr:
    //                print("decodeErr")
    //            }
    //        }
    //    }
}

extension EditProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true) // 1
        
        guard let itemProvider = results.first?.itemProvider else {
            // 선택된 항목이 없을 경우 처리
            return
        }
        
        if itemProvider.canLoadObject(ofClass: UIImage.self) { // 3
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in // 4
                DispatchQueue.main.async {
                    if let image = image as? UIImage {
                        self.profileImageView.image = image.resize(to: CGSize(width: 89, height: 89))
                    }
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
        
        
//        if itemProvider.canLoadObject(ofClass: UIImage.self) {
//                    itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
//                        if let image = image as? UIImage {
//                            // 선택된 이미지 처리
//                            DispatchQueue.main.async {
//                                // 이미지를 받아온 후에 처리할 작업
//                                // 예: 이미지뷰에 설정
//                                self?.profileImageView.image = image
//                            }
//                        }
//                    }
//                }
    }
}

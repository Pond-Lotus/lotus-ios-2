//
//  MyPageViewController.swift
//  TODORI
//
//  Created by Dasol on 2023/05/13.
//

import UIKit

class MyPageViewController: UIViewController {

    private let profileImageView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "edit-profile")?.circleMasked)
        let imageView = UIImageView(image: UIImage(named: "default-profile"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        if let nickname = UserDefaults.standard.string(forKey: "nickname") {
            label.text = nickname
        }
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        if let email = UserDefaults.standard.string(forKey: "email") {
            label.text = email
        }
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit-profile")?.resize(to: CGSize(width: 24, height: 24)), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel1: UILabel = {
        let label = UILabel()
        label.text = "환경 설정"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let changePasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 비밀번호 변경", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        let image = UIImage(named: "setting")?.resize(to: CGSize(width: 18, height: 18))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let notificationButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 알림 설정", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        let image = UIImage(named: "setting")?.resize(to: CGSize(width: 18, height: 18))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let changeThemeButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 테마 변경", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        let image = UIImage(named: "setting")?.resize(to: CGSize(width: 18, height: 18))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel2: UILabel = {
        let label = UILabel()
        label.text = "그룹 설정"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let settingGroupButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        let image = UIImage(systemName: "chevron.right")?.resize(to: CGSize(width: 10, height: 14))
        button.setImage(image, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var underlineViews: [UIView] = []

    private func createUnderlineView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private var colorViews: [UIImageView] = []

    private func createColorView(_ filename: String) -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: filename))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        editProfileButton.addTarget(self, action: #selector(editProfileButtonTapped), for: .touchUpInside)
        settingGroupButton.addTarget(self, action: #selector(settingGroupButtonTapped), for: .touchUpInside)
        
        setupUI()
    }
    
    private func setupUI() {
        let stackView1 = UIStackView(arrangedSubviews: [changePasswordButton, notificationButton, changeThemeButton])
        stackView1.axis = .vertical
        stackView1.spacing = 22
        stackView1.alignment = .leading
        
//        let stackView2 = UIStackView(arrangedSubviews: [])
        let stackView2 = UIStackView()
        colorViews.append(createColorView("redCircle"))
        colorViews.append(createColorView("yellowCircle"))
        colorViews.append(createColorView("greenCircle"))
        colorViews.append(createColorView("blueCircle"))
        colorViews.append(createColorView("pinkCircle"))
        colorViews.append(createColorView("purpleCircle"))
        for colorView in colorViews {
            stackView2.addArrangedSubview(colorView)
        }
        stackView2.axis = .horizontal
        stackView2.distribution = .equalSpacing
        
        view.addSubview(profileImageView)
        view.addSubview(nickNameLabel)
        view.addSubview(emailLabel)
        view.addSubview(editProfileButton)
        view.addSubview(titleLabel1)
        view.addSubview(stackView1)
        view.addSubview(titleLabel2)
        view.addSubview(stackView2)
        view.addSubview(settingGroupButton)
        
        for _ in 1...3 { underlineViews.append(createUnderlineView()) }
        underlineViews.forEach { view.addSubview($0) }

        underlineViews[0].snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(21)
            make.leading.trailing.equalToSuperview().offset(17)
            make.height.equalTo(1.0)
        }
        underlineViews[1].snp.makeConstraints { make in
            make.top.equalTo(stackView1.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().offset(17)
            make.height.equalTo(1.0)
        }
        underlineViews[2].snp.makeConstraints { make in
            make.top.equalTo(stackView2.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().offset(17)
            make.height.equalTo(1.0)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(77)
            make.leading.equalToSuperview().offset(22)
            make.width.equalTo(41)
            make.height.equalTo(41)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(77)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }

        emailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(98)
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(84)
            make.trailing.equalToSuperview().offset(-18)
        }

        titleLabel1.snp.makeConstraints { make in
            make.top.equalTo(underlineViews[0].snp.bottom).offset(21)
            make.leading.equalToSuperview().offset(22)
        }
        
        stackView1.snp.makeConstraints { make in
            make.top.equalTo(titleLabel1.snp.bottom).offset(19)
            make.leading.equalToSuperview().offset(18)
        }
        
        titleLabel2.snp.makeConstraints { make in
            make.top.equalTo(underlineViews[1].snp.bottom).offset(21)
            make.leading.equalToSuperview().offset(22)
        }
        
        settingGroupButton.snp.makeConstraints { make in
            make.top.equalTo(underlineViews[1].snp.bottom).offset(21)
            make.trailing.equalToSuperview().offset(-22)
        }
        
        stackView2.snp.makeConstraints { make in
            make.top.equalTo(titleLabel2.snp.bottom).offset(19)
            make.leading.equalToSuperview().offset(28)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func editProfileButtonTapped() {
        let navController = UINavigationController(rootViewController: EditProfileViewController())
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func settingGroupButtonTapped() {
        let navController = UINavigationController(rootViewController: GroupSettingViewController())
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
}

extension UIImage {
    var circleMasked: UIImage? {
        // 이미지의 크기를 가져옵니다.
        let imageRect = CGRect(origin: .zero, size: size)

        // 새로운 그래픽 컨텍스트를 만듭니다.
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, 0)

        // 원형으로 잘라낼 범위를 계산합니다.
        let path = UIBezierPath(ovalIn: imageRect)
        path.addClip()

        // 이미지를 그립니다.
        draw(in: imageRect)

        // 새로운 이미지를 가져옵니다.
        let maskedImage = UIGraphicsGetImageFromCurrentImageContext()

        // 그래픽 컨텍스트를 종료합니다.
        UIGraphicsEndImageContext()

        // 새로운 이미지를 반환합니다.
        return maskedImage
    }
}

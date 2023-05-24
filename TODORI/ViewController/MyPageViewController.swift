//
//  MyPageViewController.swift
//  TODORI
//
//  Created by Dasol on 2023/05/13.
//

import UIKit

class MyPageViewController: UIViewController {

    private var initialPosition: CGPoint = .zero
    var dimmingView: UIView?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        
        if UserSession.shared.profileImage == nil {
            imageView.image = UIImage(named: "default-profile")?.resize(to: CGSize(width: 89, height: 89))
        } else {
            if let base64String = UserSession.shared.profileImage {
                if let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
                    if let originalImage = UIImage(data: imageData) {
                        // 이미지를 정사각형으로 잘라내기 위한 크기 계산
                        let squareSize = min(originalImage.size.width, originalImage.size.height)
                        let squareRect = CGRect(x: 0, y: 0, width: squareSize, height: squareSize)
                        
                        // 정사각형으로 잘라낸 이미지 생성
                        if let croppedImage = originalImage.cgImage?.cropping(to: squareRect) {
                            let croppedUIImage = UIImage(cgImage: croppedImage)
                            
                            // 원형 이미지 생성
                            if let circularImage = croppedUIImage.circleMasked {
                                imageView.contentMode = .scaleAspectFit
                                imageView.layer.cornerRadius = imageView.frame.width / 2.0
                                imageView.clipsToBounds = true
                                imageView.layer.masksToBounds = true
                                imageView.image = circularImage
                            }
                        }
                    }
                }
            }
        }
        return imageView
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        if let nickname = UserSession.shared.nickname {
            label.text = nickname
        } else {
            label.text = "(UNKNOWN)"
        }
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        if let email = UserSession.shared.email {
            label.text = email
        } else {
            label.text = "(UNKNOWN)"
        }
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit-profile")?.resize(to: CGSize(width: 24, height: 24)), for: .normal)
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
        return button
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 로그아웃", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        let image = UIImage(named: "logout")?.resize(to: CGSize(width: 18, height: 18))
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
        print("MyPageViewController의 viewDidLoad() 입니다.")
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        view.addGestureRecognizer(tapGesture)
            
        editProfileButton.addTarget(self, action: #selector(editProfileButtonTapped), for: .touchUpInside)
        settingGroupButton.addTarget(self, action: #selector(settingGroupButtonTapped), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        setupUI()
    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        // MyPageViewController의 뷰를 터치한 경우에만 아래 코드가 실행됩니다.
        // 터치 이벤트를 소비하여 상위 뷰 컨트롤러로 전달되지 않도록 합니다.
        print("MyPageViewController의 handleTapGesture")
        gesture.cancelsTouchesInView = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserSession.shared.profileImage == nil {
            profileImageView.image = UIImage(named: "default-profile")?.resize(to: CGSize(width: 89, height: 89))
        } else {
            if let base64String = UserSession.shared.profileImage {
                if let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) {
                    if let originalImage = UIImage(data: imageData) {
                        // 이미지를 정사각형으로 잘라내기 위한 크기 계산
                        let squareSize = min(originalImage.size.width, originalImage.size.height)
                        let squareRect = CGRect(x: 0, y: 0, width: squareSize, height: squareSize)
                        
                        // 정사각형으로 잘라낸 이미지 생성
                        if let croppedImage = originalImage.cgImage?.cropping(to: squareRect) {
                            let croppedUIImage = UIImage(cgImage: croppedImage)
                            
                            // 원형 이미지 생성
                            if let circularImage = croppedUIImage.circleMasked {
                                profileImageView.contentMode = .scaleAspectFit
                                profileImageView.layer.cornerRadius = profileImageView.frame.width / 2.0
                                profileImageView.clipsToBounds = true
                                profileImageView.layer.masksToBounds = true
                                profileImageView.image = circularImage
                            }
                        }
                    }
                }
            }
        }
        
        if let nickname = UserSession.shared.nickname {
            nickNameLabel.text = nickname
        }
        
        if let email = UserSession.shared.email {
            emailLabel.text = email
        }

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupUI() {
        let stackView1 = UIStackView(arrangedSubviews: [changePasswordButton, notificationButton])
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
        view.addSubview(logoutButton)
        
        for _ in 1...4 { underlineViews.append(createUnderlineView()) }
        underlineViews.forEach { view.addSubview($0) }

        underlineViews[0].snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(21)
            make.leading.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
            make.height.equalTo(1.0)
        }
        underlineViews[1].snp.makeConstraints { make in
            make.top.equalTo(stackView1.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
            make.height.equalTo(1.0)
        }
        underlineViews[2].snp.makeConstraints { make in
            make.top.equalTo(stackView2.snp.bottom).offset(28)
            make.leading.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
            make.height.equalTo(1.0)
        }
        underlineViews[3].snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-64)
            make.leading.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
            make.height.equalTo(1.0)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(73)
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
            make.leading.equalToSuperview().offset(22)
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
            make.leading.equalToSuperview().offset(22)
            make.centerX.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(underlineViews[3].snp.bottom).offset(21)
            make.leading.equalToSuperview().offset(22)
        }
    }
    
    @objc func editProfileButtonTapped() {
//        let navController = UINavigationController(rootViewController: MyPageViewController())
//        navController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(EditProfileViewController(), animated: true)
//        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func settingGroupButtonTapped() {
//        let navController = UINavigationController(rootViewController: MyPageViewController())
//        navController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(GroupSettingViewController(), animated: true)
//        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func logoutButtonTapped() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
            
            let dimmingView = UIView(frame: keyWindow.bounds)
            dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            dimmingView.alpha = 0
            keyWindow.addSubview(dimmingView)
            
            let popupView = LogoutPopupView(title: "로그아웃", message: "로그아웃 하시겠습니까?", buttonText1: "취소", buttonText2: "로그아웃", dimmingView: dimmingView)
            popupView.delegate = self // 중요
            popupView.alpha = 0
            keyWindow.addSubview(popupView)
            popupView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.equalTo(264)
                make.height.equalTo(167)
            }
            
            UIView.animate(withDuration: 0.2) {
                popupView.alpha = 1
                dimmingView.alpha = 1
            }
        }
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        case .began:
            initialPosition = view.center
        case .changed:
//            view.center = CGPoint(x: initialPosition.x + translation.x, y: initialPosition.y)
            let newX = initialPosition.x + translation.x
            if newX > initialPosition.x {
                view.center = CGPoint(x: newX, y: initialPosition.y)
            }
        case .ended, .cancelled:
            let screenWidth = UIScreen.main.bounds.width
            
            if view.center.x > screenWidth / 2 {
                // 오른쪽으로 당겨졌으므로 다시 들어가도록 애니메이션 처리
                UIView.animate(withDuration: 0.2) {
                    self.view.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: self.view.frame.height)
                } completion: { _ in
                    self.view.removeFromSuperview()
                    self.removeFromParent()
                    self.dimmingView?.isHidden = true
                    
                }
            } else {
                // 왼쪽으로 당겨지지 않았으므로 초기 위치로 되돌림
                UIView.animate(withDuration: 0.3) {
                    self.view.center = self.initialPosition
                }
            }
        default:
            break
        }
    }
    
}

extension MyPageViewController {
    
    func logout() {
        UserService.shared.logout() {
            response in
            switch response {
            case .success(let data):
                if let json = data as? [String: Any], let resultCode = json["resultCode"] as? Int {
                    if resultCode == 200 {
                        print("이백")
                        let navController = UINavigationController(rootViewController: LogInViewController())
                        navController.modalPresentationStyle = .fullScreen
                        self.present(navController, animated: true, completion: nil)
                        
                    } else if resultCode == 500 {
                        print("오백")
                        print("로그아웃 실패")
                    }
                }
            case .failure:
                print("FUCKING fail")
            }
        }
    }
}

extension MyPageViewController: LogoutPopupViewDelegate {
    func logoutButtonTappedDelegate() {
        logout()
    }
}

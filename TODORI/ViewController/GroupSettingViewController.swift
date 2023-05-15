//
//  GroupSettingViewController.swift
//  TODORI
//
//  Created by Dasol on 2023/05/15.
//

import UIKit

class GroupSettingViewController: UIViewController {

    private func createStackView(image: UIImage?, text: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
//        stackView.spacing = 10
//        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .yellow
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints() { make in
            make.width.equalTo(500)
            make.height.equalTo(60)
        }
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.width.equalTo(23)
            make.height.equalTo(23)
        }
        
        let label = UILabel()
        label.text = text
        label.backgroundColor = .blue
        
        let button = UIButton()
        button.setImage(UIImage(named: "edit-group")?.resize(to: CGSize(width: 19, height: 19)), for: .normal)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        
        if let index = stackView.arrangedSubviews.firstIndex(of: label) {
            stackView.setCustomSpacing(16, after: stackView.arrangedSubviews[index - 1])
        }
        
        return stackView
    }
    
    private let changePasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(" 비밀번호 변경", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        let image = UIImage(named: "setting")?.resize(to: CGSize(width: 23, height: 23))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    
        setupUI()
    }

    private func setupUI() {
        // 네비게이션 바 설정
        let separatorView = UIView(frame: CGRect(x: 0, y: navigationController?.navigationBar.frame.maxY ?? 0 - 1, width: view.frame.width, height: 1))
        separatorView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        navigationController?.navigationBar.addSubview(separatorView)
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1)

        let font = UIFont.systemFont(ofSize: 16, weight: .bold)
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.black]
        let title = "그룹 설정"
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationItem.title = title
        
//        let stackView1 = UIStackView(arrangedSubviews: [changePasswordButton, notificationButton, changeThemeButton])
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        
        let firstStackView = createStackView(image: UIImage(named: "redCircle"), text: "Label 1")
        let secondStackView = createStackView(image: UIImage(named: "yellowCircle"), text: "Label 2")
        let thirdStackView = createStackView(image: UIImage(named: "greenCircle"), text: "Label 3")
        let thirdStackView2 = createStackView(image: UIImage(named: "greenCircle"), text: "Label 3")
        let thirdStackView3 = createStackView(image: UIImage(named: "greenCircle"), text: "Label 3")
        let thirdStackView4 = createStackView(image: UIImage(named: "greenCircle"), text: "Label 3")
        let thirdStackView5 = createStackView(image: UIImage(named: "greenCircle"), text: "Label 3")
        let thirdStackView6 = createStackView(image: UIImage(named: "greenCircle"), text: "Label 3")
        let thirdStackView7 = createStackView(image: UIImage(named: "greenCircle"), text: "Label 3")
        let thirdStackView8 = createStackView(image: UIImage(named: "greenCircle"), text: "Label 3")
        
        
        for _ in 1...6 { underlineViews.append(createUnderlineView()) }
        underlineViews.forEach { view.addSubview($0) }
        
        mainStackView.addArrangedSubview(firstStackView)
        mainStackView.addArrangedSubview(underlineViews[0])
        mainStackView.addArrangedSubview(secondStackView)
        mainStackView.addArrangedSubview(underlineViews[1])
        mainStackView.addArrangedSubview(thirdStackView)
        mainStackView.addArrangedSubview(underlineViews[2])
        mainStackView.addArrangedSubview(thirdStackView2)
        mainStackView.addArrangedSubview(thirdStackView3)
        mainStackView.addArrangedSubview(thirdStackView4)
        mainStackView.addArrangedSubview(thirdStackView5)
        mainStackView.addArrangedSubview(thirdStackView6)
        mainStackView.addArrangedSubview(thirdStackView7)
        mainStackView.addArrangedSubview(thirdStackView8)
        

        view.addSubview(mainStackView)
        mainStackView.backgroundColor = .purple
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(0)
            make.leading.equalToSuperview().offset(28)
            make.trailing.equalToSuperview().offset(-28)
        }
        
        underlineViews.forEach { underline in
            underline.snp.makeConstraints { make in
//                make.leading.equalToSuperview().offset(17)
                make.height.equalTo(1.0)
            }
        }
    }
    
    @objc func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
        let viewControllerToPresent = MyPageViewController() // 이동할 뷰 컨트롤러 인스턴스 생성
        viewControllerToPresent.modalPresentationStyle = .fullScreen // 화면 전체를 차지하도록 설정
        present(viewControllerToPresent, animated: true, completion: nil) // 뷰 컨트롤러 이동
    }
    
    private var underlineViews: [UIView] = []

    private func createUnderlineView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

extension GroupSettingViewController {
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

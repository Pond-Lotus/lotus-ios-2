//
//  EditGroupSettingViewController.swift
//  TODORI
//
//  Created by Dasol on 2023/05/16.
//

import UIKit

class EditGroupSettingViewController: UIViewController {
    
    private var separatorView: UIView?
    
    var color: String?
    var label: String?
    var groupName: String?
    
    private func createStackView(image: String, text: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        stackView.snp.makeConstraints() { make in
            make.width.equalTo(500)
            make.height.equalTo(60)
        }
        
        let imageView = UIImageView(image: UIImage(named: image))
        imageView.contentMode = .scaleAspectFit
        stackView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
        
        let textField = UITextField()
        textField.backgroundColor = UIColor(red: 0.954, green: 0.954, blue: 0.954, alpha: 1)
        textField.layer.cornerRadius = 8
        textField.text = self.groupName
        
        stackView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
//            make.leading.equalTo(imageView.snp.trailing).offset(10)
//            make.trailing.equalToSuperview().offset(-28)
            make.height.equalTo(41)
        }
        
        textField.delegate = self
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 30))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .medium),
            .foregroundColor: UIColor(red: 0.663, green: 0.663, blue: 0.663, alpha: 1)
        ]
        if let label = self.label {
            let attributedPlaceholder = NSAttributedString(string: label, attributes: attributes)
            textField.attributedPlaceholder = attributedPlaceholder
                        
        }
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textField)
        
        if let index = stackView.arrangedSubviews.firstIndex(of: textField) {
            stackView.setCustomSpacing(10, after: stackView.arrangedSubviews[index - 1])
        }
        return stackView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        separatorView = UIView(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 1))
        separatorView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        navigationController?.navigationBar.addSubview(separatorView!)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        separatorView?.removeFromSuperview()
        separatorView = nil
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            self.view.endEditing(true)
    }

    private func setupUI() {
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1)
        
        let font = UIFont.systemFont(ofSize: 16, weight: .bold)
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.black]
        let title = "그룹 설정"
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationItem.title = title
        
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
                
        
        //        let stackView1 = UIStackView(arrangedSubviews: [changePasswordButton, notificationButton, changeThemeButton])
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        
        if let color = color, let label = label {
            print(color)
            print(label)
            let firstStackView = createStackView(image: color, text: label)
    
            mainStackView.addArrangedSubview(firstStackView)
            
            view.addSubview(mainStackView)
            mainStackView.snp.makeConstraints { make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(24)
                make.leading.equalToSuperview().offset(28)
                make.trailing.equalToSuperview().offset(-28)
            }
        } else {
            print("label == nil")
        }
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func completeButtonTapped() {
        print("TAPPED")
        if let name = groupName {
            print("name is \(name)")
        } else {
            print("name is nil")
        }
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

extension EditGroupSettingViewController: UITextFieldDelegate {
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let currentText = textField.text ?? ""
//        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
//        print("currentText : \(currentText)")
//        print("newText : \(newText)")
//
//        return true
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let enteredText = textField.text {
            print("입력된 값: \(enteredText)")
            self.groupName = enteredText
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension EditGroupSettingViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LeftToRightTransition()
    }
}

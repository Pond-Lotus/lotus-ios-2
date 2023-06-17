//
//  FinishSignUpViewController.swift
//  TODORI
//
//  Created by Dasol on 2023/05/02.
//

import UIKit
import Lottie

class FinishSignUpViewController: UIViewController {
    private let finishLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입 완료!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 0.621, green: 0.621, blue: 0.621, alpha: 1)
        return label
    }()

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        if let nickname = UserSession.shared.nickname {
            label.text = "\(nickname)님, 환영합니다!"
        }
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인 하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.725, alpha: 1)
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "lottieFile")
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.setHidesBackButton(true, animated: false)

        view.addSubview(animationView)
        view.addSubview(finishLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(loginButton)
        
        animationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.width.height.equalTo(200)
        }
        
        finishLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height * 0.53)
            make.centerX.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(finishLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
                
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(33)
            make.centerX.equalToSuperview()
            make.width.equalTo(135)
            make.height.equalTo(39)
        }
    }
    
    @objc func loginTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

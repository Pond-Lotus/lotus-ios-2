//
//  CustomPopupView2.swift
//  TODORI
//
//  Created by Dasol on 2023/05/25.
//

import UIKit

class CustomPopupView2: UIView {
    
    weak var delegate: CustomPopupView2Delegate?
    
    var titleLabel: UILabel!
    var messageLabel: UILabel!
    var actionButton1: UIButton!
    var actionButton: UIButton!
    var dimmingView: UIView!
    
    init(title: String, message: String, buttonText: String, dimmingView: UIView) {
        super.init(frame: UIScreen.main.bounds)
        setupUI()
        
        titleLabel.text = title
        messageLabel.text = message
        actionButton.setTitle(buttonText, for: .normal)
        self.dimmingView = dimmingView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.masksToBounds = true // 나가면 짤림
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        titleLabel.textColor = UIColor(red: 0.171, green: 0.171, blue: 0.171, alpha: 1)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(37)
            $0.width.equalToSuperview()
        }
        
        messageLabel = UILabel()
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(11)
            $0.width.equalToSuperview()
        }
        
        actionButton = UIButton(type: .system)
        actionButton.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.725, alpha: 1)
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        actionButton.setTitleColor(UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1), for: .normal)
        actionButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(167 - 45)
            $0.bottom.equalToSuperview().offset(0)
            $0.width.equalToSuperview()
            $0.height.equalTo(45)
        }
    }
    
    
    @objc func loginButtonTapped() {
        delegate?.loginButtonTappedDelegate()
        self.dimmingView.isHidden = true
        self.removeFromSuperview()
    }
}

protocol CustomPopupView2Delegate: AnyObject {
    func loginButtonTappedDelegate()
}

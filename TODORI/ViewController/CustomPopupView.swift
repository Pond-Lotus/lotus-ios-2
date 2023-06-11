//
//  CustomPopupView.swift
//  TODORI
//
//  Created by Dasol on 2023/05/12.
//

import UIKit

class CustomPopupView: UIView {
    
    var titleLabel: UILabel!
    var messageLabel: UILabel!
    var actionButton: UIButton!
    var dimmingView: UIView!
    
    init(title: String, message: String, buttonText: String, buttonColor: UIColor, dimmingView: UIView) {
        super.init(frame: UIScreen.main.bounds)
        setupUI()
        
        titleLabel.text = title
        messageLabel.text = message
        actionButton.setTitle(buttonText, for: .normal)
        actionButton.backgroundColor = buttonColor
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
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        actionButton.setTitleColor(.black, for: .normal)
        actionButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(167 - 45)
            $0.bottom.equalToSuperview().offset(0)
            $0.width.equalToSuperview()
            $0.height.equalTo(45)
        }
    }
    
    @objc func closeButtonTapped() {
        self.dimmingView.isHidden = true
        self.removeFromSuperview()
      }
}

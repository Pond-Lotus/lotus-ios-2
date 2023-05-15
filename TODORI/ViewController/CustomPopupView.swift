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
    
    init(title: String, message: String, buttonText: String) {
        super.init(frame: UIScreen.main.bounds)
        setupUI()
        
        titleLabel.text = title
        messageLabel.text = message
        actionButton.setTitle(buttonText, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.masksToBounds = true // 나가면 짤림
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        titleLabel.textColor = UIColor(red: 0.171, green: 0.171, blue: 0.171, alpha: 1)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(16)
        }
        
        messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.equalToSuperview().offset(16)
//            $0.trailing.equalToSuperview().inset(16)
        }
        
        actionButton = UIButton(type: .system)
        actionButton.backgroundColor = UIColor(red: 1, green: 0.855, blue: 0.725, alpha: 1)
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        actionButton.setTitleColor(UIColor(red: 0.258, green: 0.258, blue: 0.258, alpha: 1), for: .normal)
        actionButton.layer.cornerRadius = 13
        actionButton.layer.masksToBounds = true
        actionButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-16)
            $0.width.equalTo(49)
            $0.height.equalTo(24)
        }
    }
    
    @objc func closeButtonTapped() {
          self.removeFromSuperview()
      }
}

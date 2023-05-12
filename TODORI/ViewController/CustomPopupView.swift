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
        // 팝업뷰 설정
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        // 타이틀 레이블 설정
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        // 메시지 레이블 설정
        messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        addSubview(messageLabel)
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        // 액션 버튼 설정
        actionButton = UIButton(type: .system)
        actionButton.backgroundColor = .blue
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.layer.cornerRadius = 5
        actionButton.layer.masksToBounds = true
        actionButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.top.equalTo(messageLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
    
    @objc func closeButtonTapped() {
          self.removeFromSuperview()
      }
}

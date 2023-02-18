//
//  Extension+UIViewController.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 18.02.2023.
//

import UIKit

extension UIViewController {
    
    func showToast(message : String, duration : CGFloat = 3.0, color : UIColor = UIColor.red.withAlphaComponent(0.55)) {
        let messageView = UIView(frame: .zero)
        messageView.alpha = 1
        messageView.layer.cornerRadius = 10
        messageView.clipsToBounds = true
        messageView.backgroundColor = color
        let toastLabel = UILabel()
        toastLabel.textColor = .white
        toastLabel.font = .systemFont(ofSize: 18, weight: .medium)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.numberOfLines = 0
        self.view.addSubview(messageView)
        messageView.addSubview(toastLabel)
        messageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.1)
            make.bottom.equalToSuperview().inset(UIView.HEIGHT * 0.1)
        }
        
        toastLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.top.bottom.equalToSuperview()
        }
        
        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
            messageView.alpha = 0.0
        }, completion: {(isCompleted) in
            messageView.removeFromSuperview()
        })
    }
}

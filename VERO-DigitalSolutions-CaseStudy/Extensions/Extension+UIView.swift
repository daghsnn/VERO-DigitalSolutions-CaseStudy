//
//  Extension+UIView.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 17.02.2023.
//

import UIKit

extension UIView {
    static var TOPSafeArea : CGFloat {
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let bottomInset = firstScene.windows.first?.safeAreaInsets.top else { return 0 }
        return bottomInset
    }
    static var BOTTOMSafeArea : CGFloat {
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let bottomInset = firstScene.windows.first?.safeAreaInsets.bottom else { return 0 }
        return bottomInset
    }
    
    static var WIDTH: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var HEIGHT: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    func addGradientLayer(starColor:UIColor?,endColor:UIColor?, withAnimation:Bool=false) {
        guard let starColor, let endColor else {return}
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [starColor.cgColor, endColor.cgColor]
        removeOtherGradients()
        self.layer.addSublayer(gradientLayer)
        if withAnimation {
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            animation.duration = 1
            animation.values = [-10.0, 10.0, -8.0, 8.0, -4.0, 4.0, -2.0, 2.0, 0.0]
            gradientLayer.add(animation, forKey: "shake")
        }
    }
    
    private func removeOtherGradients(){
        guard let subLayers = self.layer.sublayers else {return}
        for layer in subLayers {
            if layer is CAGradientLayer {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    func makeShadow(color: UIColor, offSet:CGSize, blur:CGFloat, opacity:Float){
        let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius)
        let shadowLayer = CALayer()
        shadowLayer.shadowPath = shadowPath.cgPath
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = blur / UIScreen.main.scale
        shadowLayer.shadowOffset = offSet
        shadowLayer.bounds = self.bounds
        shadowLayer.masksToBounds = true
        layer.insertSublayer(shadowLayer, at: 0)
    }
}
